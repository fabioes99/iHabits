import { EnvelopeSimple, Keyhole, User } from "phosphor-react"
import Input from "./Input"
import LogoImage from '../assets/logo.svg'
import { useState } from "react"
import { UserAuth } from "../context/AuthContext"
import {  useNavigate } from 'react-router-dom'


export default function CreateAcc() {

  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [error, setError] = useState("");
  const [user, setUser ] = useState({});
  const navigate = useNavigate()

  const { createUser } = UserAuth();

  const handleClick = async(e) =>{
    e.preventDefault()
     navigate('/login')
  }

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

  /*     background-color: #211b30 */
  return (
    <div style={{ marginLeft: '35%', marginTop: '2%' }} className=" border border-violet-500 rounded-lg font-semibold  px-6 py-3 items-center gap-2 flex flex-col w-96 ">
        <img src={LogoImage} alt="" />
        <div className="font-bold text-2xl mb-5 leading-11 mt-6">Crie sua conta</div>
        <div className="font-normal text-base mb-9 leading-6">Crie sua conta e comece a mudar de vida!</div>
        <form onSubmit={handleSubmit} >
          <div className="">
            <Input name="nome" onChange={(event) => {setNome(event.target.value)}}  placeholder="Nome completo" leftIcon={<User size={32} />} />
            <Input name="email" onChange={(event) => {setEmail(event.target.value)}}  placeholder="E-mail" leftIcon={<EnvelopeSimple size={32} />} />
            <Input  name="senha" onChange={(event) => {setSenha(event.target.value)}} placeholder="Senha" type="password" leftIcon={<Keyhole size={32} />}/>
          </div>
          <button 
            type="submit" 
            className=" w-full rounded-full text-white border-2 border-purple-500 py-2 px-4 text-lg font-bold capitalize bg-purple-500 text-center hover:bg-purple-600" >
            Criar Conta
          </button>
        </form>
        <div className="flex flex-row justify-between items-center mt-5">
          <button 
           className="cursor-pointer font-normal text-base leading-5 text-purple-500"
           onClick={handleClick}>Ja tenho conta. Fazer Login
          </button>
        </div>
      </div>
  )
}
