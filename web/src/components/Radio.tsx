import React from 'react';
import * as RadioGroup from '@radix-ui/react-radio-group';

const RadioGroupDemo = () => (
  <form>
    <RadioGroup.Root className="flex flex-col gap-10" defaultValue="default" aria-label="View density">
      <div style={{ display: 'flex', alignItems: 'center' }}>
        <RadioGroup.Item className="bg-white w-25 h-25 rounded-full shadow-md " value="default" id="r1">
        <div className='h-8 w-8 rounded-xl flex items-center justify-center bg-zinc-900 border-2 border-zinc-800 group-data-[state=checked]:bg-green-500 group-data-[state=checked]:border-green-50 transition-colors group-focus:ring-2 group-focus:ring-violet-600 group-focus:ring-offset-2 group-focus:ring-offset-background'>
          <RadioGroup.Indicator className="RadioGroupIndicator" />
        </div>
        </RadioGroup.Item>
        <label className="flex items-center justify-center w-full h-full relative" htmlFor="r1">
          Saude Financeira
        </label>
      </div>
      <div style={{ display: 'flex', alignItems: 'center' }}>
        <RadioGroup.Item className="RadioGroupItem" value="comfortable" id="r2">
        <div className='h-8 w-8 rounded-xl flex items-center justify-center bg-zinc-900 border-2 border-zinc-800 group-data-[state=checked]:bg-green-500 group-data-[state=checked]:border-green-50 transition-colors group-focus:ring-2 group-focus:ring-violet-600 group-focus:ring-offset-2 group-focus:ring-offset-background'>
          <RadioGroup.Indicator className="RadioGroupIndicator" />
        </div>
        </RadioGroup.Item>
        <label className="flex items-center justify-center w-full h-full relative" htmlFor="r2">
          Saude Fisica
        </label>
      </div>
      <div style={{ display: 'flex', alignItems: 'center' }}>
        <RadioGroup.Item className="RadioGroupItem" value="compact" id="r3">
        <div className='h-8 w-8 rounded-xl flex items-center justify-center bg-zinc-900 border-2 border-zinc-800 group-data-[state=checked]:bg-green-500 group-data-[state=checked]:border-green-50 transition-colors group-focus:ring-2 group-focus:ring-violet-600 group-focus:ring-offset-2 group-focus:ring-offset-background'>
          <RadioGroup.Indicator className="RadioGroupIndicator" />
        </div>
        </RadioGroup.Item>
        <label className="flex items-center justify-center w-full h-full relative" htmlFor="r3">
          Saude Mental
        </label>
      </div>
    </RadioGroup.Root>
  </form>
);

export default RadioGroupDemo;