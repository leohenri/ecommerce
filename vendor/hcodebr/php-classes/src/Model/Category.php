<?php 

namespace Hcode\Model;

use \Hcode\DB\Sql;
use \Hcode\Model;
use \Hcode\Mailer;

class Category extends Model{

	

	public static function listAll($where = 1)
	{

		$sql = new Sql();

		$instruction = "
			SELECT 
				*
			FROM
				tb_categories
			WHERE
				$where
			ORDER BY
				disablecategory ASC, descategory
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

		Category::updateFile();

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

		Category::updateFile();

	}



	public function enable()
	{

		$sql = new Sql();

		//Instrução que executará uma procedure já configurado no banco
		$instruction = "
			CALL 
				sp_categories_enable(
					:idcategory
				)
		";

		$values = array(
			":idcategory"=>$this->getidcategory()
		);
		$sql->query($instruction, $values);

		Category::updateFile();

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


	public static function updateFile()
	{

		$categories = Category::listAll("disablecategory IS NULL");

		$html = [];

		foreach ($categories as $row) {
			$tag = "<li><a href='/categories/$row[idcategory]'>$row[descategory]</a></li>";
			array_push($html, $tag);
		}

		$file = $_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'categories-menu.html';
		
		file_put_contents($file, implode($html));

	}

}



 ?>