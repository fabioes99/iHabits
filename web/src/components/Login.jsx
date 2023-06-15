import { EnvelopeSimple, Keyhole, Password } from "phosphor-react"
import Input from "./Input"
import LogoImage from '../assets/logo.svg'
import { useState } from "react"
import { UserAuth } from "../context/AuthContext"
import {  useNavigate } from 'react-router-dom'


export default function Login() {

  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [error, setError] = useState("");
  const [user, setUser ] = useState({});
  const navigate = useNavigate()

  const { createUser } = UserAuth();

  const handleSubmit = async(e) =>{
    e.preventDefault()
    setError('')
    try{
      const user = await createUser(email,senha)
      console.log(user)
      navigate('/')
    }catch(e){
      setError(e.message)
      console.log(e.message)
    }
  }

  return (
    <div style={{ marginLeft: '35%', marginTop: '2%' }} className=" border border-violet-500 rounded-lg font-semibold  px-6 py-4 items-center gap-3 flex flex-col w-96 ">
        <img src={LogoImage} alt="" />
        <div className="font-bold text-2xl mb-5 leading-11 mt-6">Faca seu cadastro</div>
        <div className="font-normal text-base mb-9 leading-6">Faca seu login e controle seus habitos</div>
        <form onSubmit={handleSubmit}>
          <Input name="email" onChange={(event) => {setEmail(event.target.value)}}  placeholder="E-mail" leftIcon={<EnvelopeSimple size={32} />} />
          <Input  name="senha" onChange={(event) => {setSenha(event.target.value)}} placeholder="Senha" type="password" leftIcon={<Keyhole size={32} />}/>
          <div>
            <button type="submit" className=" w-full rounded-full text-white border-2 border-purple-500 py-2 px-4 text-lg font-bold capitalize bg-purple-500 text-center hover:bg-purple-600" >Entrar</button>
          </div>
        </form>
        <div className="flex flex-row justify-between items-center mt-5">
          <button className="cursor-pointer font-normal text-base leading-5 text-yellow-300">Esqueci a minha senha</button>
          <button className="cursor-pointer font-normal text-base leading-5 text-purple-500 pl-10">Criar a conta</button>
        </div>
      </div>
  )
}
