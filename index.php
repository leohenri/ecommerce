<?php 

require_once("vendor/autoload.php");

//Namespace do vendor
use \Slim\Slim;
use \Hcode\Page;
use \Hcode\PageAdmin;

//Criar as routas
$app = new Slim();

$app->config('debug', true);

$app->get('/', function() {

	$page = new Page();
    
	$page->setTpl('index');

	/*
		$sql = new Hcode\DB\Sql();


		$results = $sql->select('SELECT * FROM tb_users');

		echo json_encode($results);
	*/


	//A pagina footer é carregada no destruct da class Page
});



$app->get('/admin', function() {

	$page = new PageAdmin();
    
	$page->setTpl('index');

	/*
		$sql = new Hcode\DB\Sql();


		$results = $sql->select('SELECT * FROM tb_users');

		echo json_encode($results);
	*/


	//A pagina footer é carregada no destruct da class Page
});


$app->run();

 ?>