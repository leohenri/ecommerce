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

		return $sql->select($instruction);

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
			CALL 
				sp_products_delete(
					:idproduct
				)
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
					"desphoto"=>'padrao.jpg'
				)
			);
		}

	}


	public function deletePhoto($idphotos)
	{

		$sql = new Sql();

		$instruction = "
			DELETE FROM
				tb_photos
			WHERE
				idphotos = :idphotos
			LIMIT 1
		";

		$values = array(
			":idphotos"=>$idphotos
		);
		
		$result = $sql->select($instruction, $values);

	}





}



 ?>