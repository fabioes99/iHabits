import { Check } from "phosphor-react";
import * as Checkbox from '@radix-ui/react-checkbox';
import { FormEvent } from "react";


export function Config() {  

  function createNewHabit(){

    alert('Configuracoes atualizadas com sucesso');
  }


  return (
    <form onSubmit={createNewHabit} className="w-full flex flex-col mt-6" >

    <div className="flex flex-col gap-2 mt-3">
      
          <Checkbox.Root 
            key={1} 
            className='flex items-center gap-3 group'
            >
            <div className='h-8 w-8 rounded-lg flex items-center justify-center bg-zinc-900 border-2 border-zinc-800 group-data-[state=checked]:bg-green-500 group-data-[state=checked]:border-green-50 transition-colors group-focus:ring-2 group-focus:ring-violet-600 group-focus:ring-offset-2 group-focus:ring-offset-background'>
            <Checkbox.Indicator>
              <Check size={20} className="text-white" />
            </Checkbox.Indicator>
            </div>
                        
            <span className=' text-white leading-tight '>
              Aceita Sugestoes
            </span>
          </Checkbox.Root>

          <Checkbox.Root 
            key={1} 
            className='flex items-center gap-3 group'
            >
            <div className='h-8 w-8 rounded-lg flex items-center justify-center bg-zinc-900 border-2 border-zinc-800 group-data-[state=checked]:bg-green-500 group-data-[state=checked]:border-green-50 transition-colors group-focus:ring-2 group-focus:ring-violet-600 group-focus:ring-offset-2 group-focus:ring-offset-background'>
            <Checkbox.Indicator>
              <Check size={20} className="text-white" />
            </Checkbox.Indicator>
            </div>
                        
            <span className=' text-white leading-tight '>
              Permite enviar E-mail
            </span>
          </Checkbox.Root>

          <Checkbox.Root 
            key={1} 
            className='flex items-center gap-3 group'
            >
            <div className='h-8 w-8 rounded-lg flex items-center justify-center bg-zinc-900 border-2 border-zinc-800 group-data-[state=checked]:bg-green-500 group-data-[state=checked]:border-green-50 transition-colors group-focus:ring-2 group-focus:ring-violet-600 group-focus:ring-offset-2 group-focus:ring-offset-background'>
            <Checkbox.Indicator>
              <Check size={20} className="text-white" />
            </Checkbox.Indicator>
            </div>
                        
            <span className=' text-white leading-tight '>
              Permite Agenda
            </span>
          </Checkbox.Root>

          <div className="text-purple-500 underline hover:text-white hover:no-underline">
            <a href="/info"  >Personalizar informacoes</a>
          </div>
         
       
      </div>

    <button onClick={createNewHabit} className="mt-6 rounded-lg p-4 flex items-center justify-center gap-3 font-semibold bg-green-600 hover:bg-green-400">
      <Check size={20} weight="bold" />
      Confirmar</button>
  </form>
  )
}
