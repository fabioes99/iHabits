import './styles/global.css'
import './lib/dayjs'
import Home from './pages/Home'
import { Route, Routes } from 'react-router-dom'
import Login from './components/Login'
import { Config } from './components/Config'
import { AuthContextProvider } from './context/AuthContext'
import CreateAcc from './components/Create'
import ProtectedRoute from './components/ProtectedRoute'

export function App() {

  return (
    <AuthContextProvider>
      <Routes>
        <Route path="/login" element={ <Login /> } />
        <Route path="/" element={ <ProtectedRoute><Home /></ProtectedRoute> } />
        <Route path="/config" element={ <ProtectedRoute><Config /></ProtectedRoute> } />
        <Route path="/create" element={ <CreateAcc /> } />
      </Routes>
    </AuthContextProvider>
   
  )
}

//componente: Reaproveitar / isolar 
// Propriedade: uma info enviada para modificar um componente visual ou comportamentalmente