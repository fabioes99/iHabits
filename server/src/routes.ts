import {FastifyInstance} from 'fastify'
import { z } from 'zod'
import { prisma } from './lib/prisma'
import dayjs from 'dayjs';

export async function appRoutes(app: FastifyInstance){

  app.post('/habits', async (request)=> {
    const createHabitBody = z.object({
      title: z.string(),
      weekDays: z.array( z.number().min(0).max(6) )
    })

    const today = dayjs().startOf('day').toDate();

    const { title, weekDays} = createHabitBody.parse(request.body)
    const habits = await prisma.habit.create({
      data: {
        title,
        created_at: today,
        weekDays: {
          create: weekDays.map( weekDay => {
            return {
              week_day: weekDay,
            }
          })
        }
      }
    })
  
    return habits;
  })

  app.get('/day',  async (request)=> {
    const getDayParams = z.object({
      date: z.coerce.date()
    })

    const { date } = getDayParams.parse(request.query)
    //request.query signfica que os parametros da query seroa passados pela url 

    //todos habitos possiveis naquele 
    //e habitos que ja foram completados
    const parsedDate = dayjs(date).startOf('day');
    const weekDay = parsedDate.get('day');
    const possibleHabits = await prisma.habit.findMany({
      where: {
        created_at: {
          lte: date,
        },
        weekDays: {
          some: {
            week_day: weekDay,
          }
        }
      }
    })

    const day = await prisma.day.findUnique({
      where: {
        date: parsedDate.toDate(),
      },
      include: {
        dayHabits: true,
      }
    })

    const completedHabits = day?.dayHabits.map(dayHabit => {
      return dayHabit.habit_id;
    })

    return {
      possibleHabits,
      completedHabits
    }
  })

  //completar / nao completar um habito

  app.patch('/habits/:id/toggle', async (request) =>{
    const toggleHabitParams = z.object({
      id: z.string().uuid(),
    })

    const {id} = toggleHabitParams.parse(request.params)
    // logica para permitir so atualizar habitos na data do dia, nao sendo retroativo
    const today = dayjs().startOf('day').toDate();

    let day = await prisma.day.findUnique({
      where: {
        date: today,
      }
    })

    if(!day){
      day = await prisma.day.create({
        data: {
          date: today,
        }
      })
    }

    const dayHabit = await prisma.dayHabit.findUnique({
      where: {
        day_id_habit_id: {
          day_id: day.id,
          habit_id: id,
        }
      }
    })

    if(dayHabit){
      //se tiver o habito no dia, remove a marcacao
      await prisma.dayHabit.delete({
        where: {
          id: dayHabit.id,
        }
      })
    }else{
      await prisma.dayHabit.create({
        data: {
          day_id: day.id,
          habit_id: id,
        }
      })
    }

   
  })


  app.get('/summary', async () => {
    //retornar um array de objetos [ { date , amount, completed}, {}, {}]

    const summary = await prisma.$queryRaw`
    SELECT d.id, d.date, ( 
      SELECT 
      cast(count(*) as float)
      from day_habits dh where dh.day_id = d.id
    ) as completed, (
      SELECT 
      cast(count(*) as float)
      from habit_week_days hw 
      join habits h on h.id = hw.habit_id
      where hw.week_day = cast( strftime('%w', d.date/1000.0, 'unixepoch') as int) and h.created_at <= d.date
    ) as amount
    from days d

    `

    return summary;
  });
}

