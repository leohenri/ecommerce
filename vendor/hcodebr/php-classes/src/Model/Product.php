<?php 

namespace Hcode\Model;

use \Hcode\DB\Sql;
use \Hcode\Model;

class Product extends Model{

	private $directoryPhotos;

	public function __construct(){

		$this->directoryPhotos = 	$_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . 
							"res" . DIRECTORY_SEPARATOR . 
							"site" . DIRECTORY_SEPARATOR . 
							"img" . DIRECTORY_SEPARATOR . 
							"products" . DIRECTORY_SEPARATOR;

	}

	public static function listAll($where = 1)
	{

		$sql = new Sql();

		$instruction = "
			SELECT 
				*
			FROM
				tb_products
			WHERE
				$where
			ORDER BY
				desproduct
		";

		$results = $sql->select($instruction);


		//Verifica em quais Categorias os produtos foram incluidos
		foreach ($results as $key => $product) {

			$categories = Product::getCategories($product['idproduct']);

			$results[$key] = array_merge($product, $categories);
		
		}

		return $results;

	}



	public static function listAllProdPhotos($where = 1)
	{

		$sql = new Sql();

		$instruction = "
			SELECT 
				*
			FROM
				tb_products a
					INNER JOIN
				tb_photos b USING (idproduct)
			WHERE
				$where
			GROUP BY
				b.idproduct
			ORDER BY
				desproduct
		";

		return $sql->select($instruction);

	}


	public static function listAllProductCategory($idCategory)
	{

		$sql = new Sql();

		$instruction = "
			SELECT 
				*
			FROM
				tb_products a
					LEFT JOIN
				tb_categoriesproducts b ON a.idProduct = b.idProduct
					LEFT JOIN
				tb_photos c ON b.idProduct = c.idProduct 
			WHERE
				b.idcategory = :idcategory
			GROUP BY
				c.idproduct
		";

		$param = array(
			':idcategory'=>$idCategory
		);

		$results = $sql->select($instruction,$param);

		return $results;

	}


	public function save()
	{

		$sql = new Sql();

		
		//Instrução que executará uma procedure já configurado no banco
		$instruction = "
			CALL 
				sp_products_save(
					:idproduct,
					:desproduct,
					:vlprice,
					:vlwidth,
					:vlheight,
					:vllength,
					:vlweight,
					:desurl
				)
		";

		$values = array(
			":idproduct"  => $this->getidproduct(),
			":desproduct" => $this->getdesproduct(),
			":vlprice"    => $this->getvlprice(),
			":vlwidth"    => $this->getvlwidth(),
			":vlheight"   => $this->getvlheight(),
			":vllength"   => $this->getvllength(),
			":vlweight"   => $this->getvlweight(),
			":desurl"     => $this->getdesurl()

		);

		$result = $sql->select($instruction, $values);

		$this->setData($result[0]);

	}


	public function delete()
	{

		$sql = new Sql();

		//Instrução que executará uma procedure já configurado no banco
		$instruction = "
			DELETE FROM
				tb_products
			WHERE
				idproduct = :idproduct
			LIMIT 1
		";

		$values = array(
			":idproduct"=>$this->getidproduct()
		);
		$sql->query($instruction, $values);

	}


	public function get($idproduct)
	{

		$sql = new Sql();

		$instruction = "
			SELECT 
				*
			FROM
				tb_products
			WHERE
				idproduct = :idproduct
			LIMIT 
				1
		";

		$values = array(
			":idproduct"=>$idproduct
		);
		
		$result = $sql->select($instruction, $values);

		$this->setData($result[0]);

	}


	


	public function addPhoto($file)
	{
		$ext = explode(".", $file['name']);
		$ext = strtolower(end($ext));

		switch ($ext) {
			case 'jpg':
			case 'jpeg':
				$image = imagecreatefromjpeg($file["tmp_name"]);
				break;
			case 'gif':
				$image = imagecreatefromgif($file["tmp_name"]);
				break;
			case 'png':
				$image = imagecreatefrompng($file["tmp_name"]);
				break;
		}
		
		$fileName = $this->getidproduct() . '-' . date("YmdHis") . ".jpg";
		$diretoryFileName = $this->directoryPhotos . $fileName;

		imagejpeg($image, $diretoryFileName);

		imagedestroy($image);



		$sql = new Sql();

		$instruction = "
			INSERT INTO 
				tb_photos(
					idproduct,
					desphoto
				)VALUES(
					:idproduct,
					:desphoto
				);
		";

		$values = array(
			":idproduct"=>$this->getidproduct(),
			":desphoto"=>$fileName
		);
		
		$sql->select($instruction, $values);


	}


	public function getPhotos($idproduct)
	{

		
		$sql = new Sql();

		$instruction = "
			SELECT 
				*
			FROM
				tb_photos
			WHERE
				idproduct = :idproduct
		";

		$values = array(
			":idproduct"=>$idproduct
		);
		
		$result = $sql->select($instruction, $values);

		if(count($result) > 0)
		{
			return $result;
		}else{
			return array(
				array(
					"idphoto"=>1,
					"desphoto"=>'padrao.jpg'
				)
			);
		}

	}


	public function deletePhoto($idphoto)
	{

		$sql = new Sql();

		$instruction = "
			DELETE FROM
				tb_photos
			WHERE
				idphoto = :idphoto
			LIMIT 1
		";

		$values = array(
			":idphoto"=>$idphoto
		);
		
		$result = $sql->select($instruction, $values);

	}


	public static function getCategories($idProduct)
	{
		
		$sql = new Sql();

		$instruction = "
			SELECT
				GROUP_CONCAT(descategory) AS descategory
			FROM
				tb_products a
					LEFT JOIN
				tb_categoriesproducts b USING (idproduct)
					LEFT JOIN
				tb_categories c USING (idcategory)
			WHERE
				idproduct = :idproduct
			GROUP BY
				b.idproduct
		";
		$param = array(
			":idproduct"=>$idProduct
		);

		$result = $sql->select($instruction, $param);

		return $result[0];

	}


}



 ?>