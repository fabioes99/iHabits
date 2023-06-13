import { SummaryTable } from "../../components/SummaryTable";
import { Header } from '../../components/Header'

export default function Home() {
  return (
    <div className="w-screen h-screen flex items-center">
    <div className="w-full max-w-5xl px-6 flex flex-col gap-16">
      <Header />
      <SummaryTable />
    </div>
  </div>
  )
}
