import { Plus, X, Gear, User, SignOut } from "phosphor-react";
import { useState } from "react";
import LogoImage from '../assets/logo.svg'
import { Config } from "./Config";
import Dialogo from "./Dialog";
import { NewHabitForm } from "./NewHabitForm";

export function Header() {
  //funcionamento  imperativo(js, html) vs declarativo(react)
  let [isModalOpen, setIsModalOpen] = useState(false);
  function clicked(){
    setIsModalOpen(true);
  }


  return (
    <div className="w-full pl-10 mx-auto flex items-center justify-between">
      <img src={LogoImage} alt="" />

      <Dialogo 
        title={"Novo Habito"} 
        dialogTitle={"Criar Habito"} 
        icone={<Plus size={20} className="text-violet-500" />} 
        conteudo={<NewHabitForm/>} 
      />

      <Dialogo 
        title={" Configuracoes"} 
        dialogTitle={"Configuracoes"} 
        icone={ <Gear size={20} className="text-violet-500" />} 
        conteudo={ <Config />} 
      />
     
      <div className="flex gap-5">
      <User size={32} />
        Bem Vindo Fabio!
      </div>
      <div className="flex gap-3">
       <a href="/login"><SignOut size={32} /></a>LogOut
      </div>
    </div>
  );
}