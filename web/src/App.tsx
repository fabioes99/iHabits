import './styles/global.css'
import { Header } from './components/Header'
import { SummaryTable } from './components/SummaryTable'
import './lib/dayjs'
import Login from './components/Login'

export function App() {

  return (
    <div className="w-screen h-screen flex items-center">
    <div className="w-full max-w-5xl px-6 flex flex-col gap-16">
      <Login />
    </div>
  </div>
  )
}




//componente: Reaproveitar / isolar 
// Propriedade: uma info enviada para modificar um componente visual ou comportamentalmente