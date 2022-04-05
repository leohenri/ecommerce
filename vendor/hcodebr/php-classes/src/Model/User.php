<?php 

namespace Hcode\Model;

use \Hcode\DB\Sql;
use \Hcode\Model;
use \Hcode\Mailer;

class User extends Model{

	const SESSION = "User";
	const SECRET = "1234567890123456";
	const SECRET_IV = "HcodePhp7_Secret_IV";

	const ERROR = "UserError";
	const ERROR_REGISTER = "UserErrorRegister";
	const SUCCESS = "UserSucesss";

	public static function login($login, $password){

		$sql = new Sql();

		$results = $sql->select("SELECT * FROM tb_users WHERE deslogin LIKE :LOGIN", array(
			":LOGIN"=>$login
		));

		if(count($results) === 0){

			throw new \Exception("Usuário inexistente ou senha inválida.", 1);

		}

		$data = $results[0];

		if(password_verify($password, $data['despassword']) === true){

			$user = new User();

			$user->setData($data);

			$_SESSION[User::SESSION] = $user->getValues();

			return $user;

		}else{

			throw new \Exception("Usuário inexistente ou senha inválida.", 1);

		}

	}


	public static function verifyLogin($inadmin = true)
	{

		if(
			!isset($_SESSION[User::SESSION])
			||
			!$_SESSION[User::SESSION]
			||
			!(int)$_SESSION[User::SESSION]["iduser"] > 0
			||
			(bool)$_SESSION[User::SESSION]["inadmin"] !== $inadmin
		){

			header("Location: /admin/login");
			exit;

		}

	}


	public static function logout()
	{

		$_SESSION[User::SESSION] = NULL;

	}

	public static function listAll()
	{

		$sql = new Sql();

		$instruction = "
			SELECT 
				*,
				SUBSTRING(despassword, 1, 10) = 'Disable in' AS userdisable
			FROM
				tb_users U
					INNER JOIN
				tb_persons P USING(idperson)
			ORDER BY
				desperson
		";

		return $sql->select($instruction);

	}

	public function save(){

		$sql = new Sql();

		
		//Instrução que executará uma procedure já configurado no banco
		$instruction = "
			CALL 
				sp_users_save(
					:desperson, 
					:deslogin, 
					:despassword, 
					:desemail, 
					:nrphone, 
					:inadmin
				)
		";

		$values = array(
			":desperson"=>$this->getdesperson(), 
			":deslogin"=>$this->getdeslogin(), 
			":despassword"=>$this->getdespassword(), 
			":desemail"=>$this->getdesemail(), 
			":nrphone"=>$this->getnrphone(), 
			":inadmin"=>$this->getinadmin()
		);
		$result = $sql->select($instruction, $values);

		$this->setData($result[0]);

	}


	public function update()
	{

		$sql = new Sql();

		//Instrução que executará uma procedure já configurado no banco
		$instruction = "
			CALL 
				sp_usersupdate_save(
					:iduser,
					:desperson, 
					:deslogin, 
					:despassword, 
					:desemail, 
					:nrphone, 
					:inadmin
				)
		";

		$values = array(
			":iduser"=>$this->getiduser(),
			":desperson"=>$this->getdesperson(), 
			":deslogin"=>$this->getdeslogin(), 
			":despassword"=>$this->getdespassword(), 
			":desemail"=>$this->getdesemail(), 
			":nrphone"=>$this->getnrphone(), 
			":inadmin"=>$this->getinadmin()
		);
		$result = $sql->select($instruction, $values);

		$this->setData($result[0]);

	}


	public function delete()
	{

		$sql = new Sql();
		
		$instruction = "
			UPDATE 
				tb_users
			SET
				despassword = CONCAT('Disable in ', NOW()),
				userdisable = 1
			WHERE
				iduser = :iduser
			LIMIT 1
		";

		$values = array(
			":iduser"=>$this->getiduser()
		);
		
		$sql->select($instruction, $values);

	}


	public function get($iduser){

		$sql = new Sql();

		$instruction = "
			SELECT 
				*
			FROM
				tb_users U
					INNER JOIN
				tb_persons P USING(idperson)
			WHERE
				U.iduser = :iduser
			LIMIT 
				1
		";

		$values = array(
			":iduser"=>$iduser
		);
		
		$result = $sql->select($instruction, $values);

		$this->setData($result[0]);

	}


	public static function getForgot($email)
	{

		$sql = new Sql();

		$instruction = "
			SELECT 
				* 
			FROM 
				tb_users U
					INNER JOIN
				tb_persons P USING(idperson)
			WHERE 
				P.desemail = :desmail
			LIMIT 1;
		";
		$values = array(
			":desmail"=>$email
		);

		$results = $sql->select($instruction, $values);

		if(count($results) !== 1){	

			throw new \Exception("Não é possível recuperar a senha.", 1);

		}else{

			$data = $results[0];

			$instruction = "
				CALL
					sp_userspasswordsrecoveries_create(
						:iduser,
						:desip
					)
			";
			$param = array(
				":iduser"=>$data['iduser'],
				":desip"=>$_SERVER['REMOTE_ADDR']
			);

			$results2 = $sql->select($instruction, $param);

			if(count($results2) !== 1){

				throw new \Exception("Não é possível recuperar a senha.", 1);

			}else{

				$dataRecovery = $results2[0];

				$code = openssl_encrypt($dataRecovery['idrecovery'], 'AES-128-CBC', pack("a16", User::SECRET), 0, pack("a16", User::SECRET_IV));

				$code = base64_encode($code);
				
				/*
				if ($inadmin === true) {

					$link = "http://www.leo.com.br/admin/forgot/reset?code=$code";

				} else {

					$link = "http://www.leo.com.br/forgot/reset?code=$code";
					
				}				
				*/
			
				$link = "http://www.leo.com.br/admin/forgot/reset?code=$code";
			
				$mailer = new Mailer($data['desemail'], $data['desperson'], "Redefinir senha da Ecomerce LHB", "forgot", array(
					"name"=>$data['desperson'],
					"link"=>$link
				));				

				return $mailer->send() === true ? true : false;
			}
		}

	}

	public static function validForgotDecrypt($code){

		$code = base64_decode($code);

		$idrecovery = openssl_decrypt($code, 'AES-128-CBC', pack("a16", User::SECRET), 0, pack("a16", User::SECRET_IV));

		$sql = new Sql();

		$instruction = "
			SELECT
				*
			FROM
				tb_userspasswordsrecoveries A
					INNER JOIN
				tb_users B USING(iduser)
					INNER JOIN
				tb_persons C USING(idperson)
			WHERE
				A.idrecovery = :idrecovery AND
				A.dtrecovery IS NULL AND
				DATE_ADD(A.dtregister, INTERVAL 1 HOUR) >= NOW()
			LIMIT 1
		";	
		$param = array(
			":idrecovery"=>$idrecovery
		);
		$results = $sql->select($instruction, $param);

		if(count($results) === 0){
			throw new \Exception('Não foi possi recuperar a senha.', 1);
		}

		return $results[0];

	}

	public static function setForgotUsed($idrecovery){

		$sql = new Sql();

		$sql->query("UPDATE tb_userspasswordsrecoveries SET dtrecovery = NOW() WHERE idrecovery = :idrecovery", array(
			':idrecovery'=>$idrecovery
		));



	}


	public function setPassword($password){

		$sql = new Sql();

		$results = $sql->query("UPDATE tb_users SET despassword = :password WHERE iduser = :iduser LIMIT 1", array(
			':password'=>$password,
			':iduser'=>$this->getiduser()
		));

	}


	public static function encryptPassword($password){

		return password_hash($password, PASSWORD_DEFAULT, ["cost"=>12]);

	}

}



 ?>