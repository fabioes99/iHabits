import './styles/global.css'
import './lib/dayjs'
import Login from './components/Login'
import Home from './pages/Home'

import {
  BrowserRouter as Router,
  Routes,
  Route
} from 'react-router-dom'

export function App() {

  return (
  <Router>
  <Routes>
    <Route path="/login" element={<Login />} />
    <Route path="/" element={<Home />} />
  </Routes>
  </Router>
  )
}

//componente: Reaproveitar / isolar 
// Propriedade: uma info enviada para modificar um componente visual ou comportamentalmente