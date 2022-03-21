<?php 

namespace Hcode\Model;

use \Hcode\DB\Sql;
use \Hcode\Model;
use \Hcode\Mailer;

class Category extends Model{

	

	public static function listAll()
	{

		$sql = new Sql();

		$instruction = "
			SELECT 
				*
			FROM
				tb_categories
		";

		return $sql->select($instruction);

	}

	public function save()
	{

		$sql = new Sql();

		
		//Instrução que executará uma procedure já configurado no banco
		$instruction = "
			CALL 
				sp_categories_save(
					:idcategory,
					:descategory
				)
		";

		$values = array(
			":idcategory"=>$this->getidcategory(),
			":descategory"=>$this->getdescategory()
		);
		$result = $sql->select($instruction, $values);

		$this->setData($result[0]);

	}


	public function delete()
	{

		$sql = new Sql();

		//Instrução que executará uma procedure já configurado no banco
		$instruction = "
			CALL 
				sp_categories_disable(
					:idcategory
				)
		";

		$values = array(
			":idcategory"=>$this->getidcategory()
		);
		$sql->query($instruction, $values);


	}


	public function get($idcategory)
	{

		$sql = new Sql();

		$instruction = "
			SELECT 
				*
			FROM
				tb_categories
			WHERE
				idcategory = :idcategory
			LIMIT 
				1
		";

		$values = array(
			":idcategory"=>$idcategory
		);
		
		$result = $sql->select($instruction, $values);

		$this->setData($result[0]);

	}



}



 ?>