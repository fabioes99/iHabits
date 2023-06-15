import './styles/global.css'
import './lib/dayjs'
import Home from './pages/Home'
import { Route, Routes } from 'react-router-dom'
import Login from './components/Login'
import { Config } from './components/Config'
import { AuthContextProvider } from './context/AuthContext'


export function App() {

  return (
    <AuthContextProvider>
      <Routes>
        <Route path="/" element={ <Home /> } />
        <Route path="/login" element={ <Login /> } />
        <Route path="/config" element={ <Config /> } />
      </Routes>
    </AuthContextProvider>
   
  )
}

//componente: Reaproveitar / isolar 
// Propriedade: uma info enviada para modificar um componente visual ou comportamentalmente