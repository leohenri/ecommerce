<?php 

function formatPrice(float $vlprice)
{

	return number_format($vlprice, 2, ',', '.');

}

function formatDateBr($date)
{

	//2022-12-25 12:00:00
	if(substr($date,4,1) === '-' && substr($date,7,1) === '-')
	{

		$dateBr = substr($date,8,2) . '/' . substr($date,5,2) . '/' . substr($date,0,4);
	
	}

	if(strlen($date) === 19)
	{

		$dateBr = $dateBr . ' ' . substr($date,11,8);
	
	}
	
	return $dateBr;

}


 ?>