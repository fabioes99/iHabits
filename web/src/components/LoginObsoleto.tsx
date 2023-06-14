import { EnvelopeSimple, Keyhole } from "phosphor-react"
import Input from "./Input"
import LogoImage from '../assets/logo.svg'
import { useState } from "react"
import { createUserWithEmailAndPassword
,onAuthStateChanged, signOut, signInWithEmailAndPassword
 } from "firebase/auth"
import { auth } from "../firebase-config"


export default function Login() {

  const [registrarEmail, setRegistrarEmail] = useState("");
  const [registrarSenha, setRegistrarSenha] = useState("");
  const [loginEmail, setLoginEmail] = useState("");
  const [loginSenha, setLoginSenha] = useState("");

  const [user, setUser ] = useState({});

  onAuthStateChanged(auth, (currentUser) => {
    setUser(currentUser);
  })

  // user?.email

  const registrar = async() =>{

    try{
      const user = await signInWithEmailAndPassword( auth, loginEmail, loginSenha)
      console.log(user);
    }catch(error){
      console.log(error.message);
    }
    
  }


  const logar = async() =>{

    try{
      const user = await createUserWithEmailAndPassword( auth, loginEmail, loginSenha)
      console.log(user);
    }catch(error){
      console.log(error.message);
    }
  }

  const logout = async() => {
    await signOut(auth);
  }

  return (
    <div className=" border border-violet-500 rounded-lg font-semibold  px-6 py-4 items-center gap-3 flex flex-col w-96 absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
        <img src={LogoImage} alt="" />
        <div className="font-bold text-2xl mb-5 leading-11 mt-6">Faca seu cadastro</div>
        <div className="font-normal text-base mb-9 leading-6">Faca seu login e controle seus habitos</div>
        <form >
          <Input name="email" onchange={(event) => {setLoginEmail(event.target.value)}}  placeholder="E-mail" leftIcon={<EnvelopeSimple size={32} />} />
          <Input name="senha" onchange={(event) => {setLoginSenha(event.target.value)}} placeholder="Senha" type="password" leftIcon={<Keyhole size={32} />}/>
          <div>
            <button onClick={registrar} className="flex items-center justify-center cursor-pointer rounded-full text-white border-2 border-purple-500 py-2 px-4 text-lg font-bold capitalize bg-purple-500 relative text-center hover:bg-purple-600" >Entrar</button>
          </div>
        </form>
        <div className="flex flex-row justify-between items-center mt-5">
          <div className="cursor-pointer font-normal text-base leading-5 text-yellow-300">Esqueci a minha senha</div>
          <div className="cursor-pointer font-normal text-base leading-5 text-purple-500 pl-10">Criar a conta</div>
        </div>
      </div>
  )
}
