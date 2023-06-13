import LogoImage from '../../assets/logo.svg';
import * as Checkbox from '@radix-ui/react-checkbox';
import { Check } from "phosphor-react";
import RadioGroupDemo from '../../components/Radio';

export default function Info() {

  function createNewHabit(){

    alert('Configuracoes atualizadas com sucesso');
  }


  return (
    <div style={{ marginLeft: '33%', marginTop: '2rem', marginBottom: '2rem'  }} className=" border border-violet-500 rounded-lg font-semibold  px-6 py-4 items-center gap-1 flex flex-col w-96 justify-center  ">
    <a href='/' className="m-10">
     <img src={LogoImage} alt="" />
    </a>
   
   <div className='w-80 flex flex-col m-10'>
    <label htmlFor="title" className="font-semibold leading-tight">
        Tem filhos?
      </label>

      <input type="text" id="title" placeholder="0, 1, 2, 3"
      className="p-4 rounded-lg mt-3 bg-zinc-800 text-white placeholder:text-zinc-400"  
      autoFocus
      />

   </div>


   <div className='w-80 flex flex-col m-10'>
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
            Trabalha ?
          </span>
      </Checkbox.Root>
   </div>

   <div className='w-80 flex flex-col m-10'>
   <label htmlFor="title" className="font-semibold leading-tight mb-10">
        Areas
      </label>
    <RadioGroupDemo />
   </div>
  
   <div className='w-80 flex flex-col m-10'>
   <button onClick={createNewHabit} className="mt-6 rounded-lg p-4 flex items-center justify-center gap-3 font-semibold bg-green-600 hover:bg-green-400">
      <Check size={20} weight="bold" />
      Confirmar</button>
    </div>
  </div>
  )
}
