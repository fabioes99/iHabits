
export default function Input({ leftIcon, name , ...rest}) {
  return (
  <>
    <div className="w-full border-b-1 border-solid border-[#3B3450] flex items-center mb-20">
          {leftIcon ? <div>{leftIcon}</div> : null}
          <input className="border border-violet-500 rounded-lg pl-5 bg-transparent text-white w-full h-30" {...rest}/>
    </div>
  </>
      
  )
}
