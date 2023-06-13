import { Plus, X, Gear, User, SignOut } from "phosphor-react";
import { useState } from "react";
import * as Dialog from '@radix-ui/react-dialog';

import LogoImage from '../assets/logo.svg'
import { NewHabitForm } from "./NewHabitForm";
import { Config } from "./Config";

export function Header() {
  //funcionamento  imperativo(js, html) vs declarativo(react)
  let [isModalOpen, setIsModalOpen] = useState(false);
  function clicked(){
    setIsModalOpen(true);
  }


  return (
    <div className="w-full max-w-3xl mx-auto flex items-center justify-between">
      <img src={LogoImage} alt="" />

      <Dialog.Root>
        <Dialog.Trigger
          type="button"
          className="border border-violet-500 font-semibold rounded-lg px-6 py-4 flex items-center gap-3 hover:border-violet-300"
        >
          <Plus size={20} className="text-violet-500" />
          Novo habito
        </Dialog.Trigger>

        <Dialog.Portal>
          <Dialog.Overlay className="w-screen h-screen bg-black/80 fixed inset-0" />

          <Dialog.Content className="absolute p-10 bg-zinc-900 rounded-2xl w-full max-w-md top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
            <Dialog.Close className="absolute right-6 top-6 text-zinc-400 hover:text-zinc-200">
              <X size={24} aria-label="Fechar"  />
            </Dialog.Close>

            <Dialog.Title className="text-3xl leading-tight font-extrabold">
              Criar hábito
            </Dialog.Title>

           <NewHabitForm />
          </Dialog.Content>
        </Dialog.Portal>

      </Dialog.Root>


      <Dialog.Root>
        <Dialog.Trigger
          type="button"
          className="border border-violet-500 font-semibold rounded-lg px-6 py-4 flex items-center gap-3 hover:border-violet-300"
        >
          <Gear size={20} className="text-violet-500" />
         Configuracoes
        </Dialog.Trigger>

        <Dialog.Portal>
          <Dialog.Overlay className="w-screen h-screen bg-black/80 fixed inset-0" />

          <Dialog.Content className="absolute p-10 bg-zinc-900 rounded-2xl w-full max-w-md top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
            <Dialog.Close className="absolute right-6 top-6 text-zinc-400 hover:text-zinc-200">
              <X size={24} aria-label="Fechar"  />
            </Dialog.Close>

            <Dialog.Title className="text-3xl leading-tight font-extrabold">
              Configuracoes
            </Dialog.Title>

           <Config />
          </Dialog.Content>
        </Dialog.Portal>

      </Dialog.Root>

      <User size={32} />
      <div>
        Bem Vindo Fabio!
      </div>
      <a href="/login"><SignOut size={32} /></a>
      

     
    </div>
  );
}