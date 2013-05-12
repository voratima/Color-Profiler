package com.enlighten.datastructure
{

	//private i:Number;
	//private list:Array;
	
	public class BinarySearch
	{
		public function search(list:Array, searchItem:Number)
		{
			//trace(list);
			if(list.length==1){
				if(searchItem == Number(list[0]))
				{	return true;
				}else{
					return false;
				}
			}else{
				var i:Number= Math.round(list.length/2);
				//trace("\t"+i+": "+searchItem+" - "+list[i]);//+" type:"+typeof(searchItem)+"/"+typeof(Number(list[i])));
			
				if(searchItem == Number(list[i]))
				{	return true;
				}else if(searchItem < Number(list[i])){
					return search(list.slice(0,i), searchItem);
				}else if(searchItem > Number(list[i])){
					return search(list.slice(i,list.length), searchItem);
				}else{
					return false;
				}
			}
		}
	}
}