import { EnvelopeSimple, Keyhole } from "phosphor-react"
import Input from "./Input"
import LogoImage from '../assets/logo.svg'

export default function Login() {

  return (
    <div className=" border border-violet-500 font-semibold rounded-lg px-6 py-4 items-center gap-3 flex flex-col w-96">
        <img src={LogoImage} alt="" />
        <div className="font-bold text-2xl mb-5 leading-11">Faca seu cadastro</div>
        <div className="font-normal text-base mb-9 leading-6">Faca seu login e controle seus habitos</div>
        <form >
          <Input name="email"  placeholder="E-mail" leftIcon={<EnvelopeSimple size={32} />} />
          <Input name="senha"  placeholder="Senha" type="password" leftIcon={<Keyhole size={32} />}/>
          <div  className="cursor-pointer rounded-full text-white border-2 border-purple-500 py-2 px-4 text-lg font-bold capitalize bg-purple-500 relative text-center hover:bg-purple-600" >Entrar</div>
        </form>
        <div className="flex flex-row justify-between items-center mt-5">
          <div className="cursor-pointer font-normal text-base leading-5 text-yellow-300">Esqueci a minha senha</div>
          <div className="cursor-pointer font-normal text-base leading-5 text-purple-500 pl-10">Criar a conta</div>
        </div>
      </div>
  )
}
