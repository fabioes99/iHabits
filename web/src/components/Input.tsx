
export default function Input({ leftIcon, name ,  ...rest}) {
  return (
  <>
    <div className="w-full max-w-[275px] h-30 border-b-1 border-solid border-[#3B3450] flex items-center mb-28">
          {leftIcon ? <div>{leftIcon}</div> : null}
          <input className="bg-transparent text-white w-full border-0 h-30" {...rest}/>
    </div>
  </>
      
  )
}
