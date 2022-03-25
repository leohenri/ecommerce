<?php 
session_start();
require_once("vendor/autoload.php");

//Namespace do vendor
use \Slim\Slim;
use \Hcode\Page;
use \Hcode\PageAdmin;
use \Hcode\Model\User;
use \Hcode\Model\Category;
use \Hcode\Model\Product;

//Criar as routas
$app = new Slim();

$app->config('debug', true);

/****************************************************************************************************************************
 * 
 * FRONTEND
 * @classe Page()
 * 
 ***************************************************************************************************************************/


/**
 * @Route /
 * @method GET
 * @param Sem parametros via GET ou POST
 * A classe Page monta o layout com cabeçalho, corpo e rodapé e carrega a pagina index.php no corpo da página
 */
$app->get('/', function() {

	$page = new Page();
    
	$page->setTpl('index');

});




$app->get("/categories/:idcategory", function($idcategory){

	$category = new Category();

	$category->get((int)$idcategory);

	$page = new Page();

	$page->setTpl("/category", array(
		"category"=>$category->getValues(),
		"products"=>array("desproduct"=>"leandro")
	));
});



/****************************************************************************************************************************
 *
 * BACKEND
 * @class PageAdmin()
 * 
 ***************************************************************************************************************************/


/**
 * @Route /admin/login
 * @method GET
 * @param Sem parametros via GET ou POST
 * A classe PageAdmin, receberá dois parametros para montar layout SEM cabeçalho/corpo/rodapé do template Backend e carrega a pagina login no corpo
 */
$app->get('/admin/login', function() {

	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);
    
	$page->setTpl('login');

});


/**
 * @Route /admin/login
 * @method POST
 * @param $_POST recebe os dados do usuario e senha para realizar o login
 * 
 */
$app->post('/admin/login', function() {

	User::login($_POST['login'], $_POST['password']);

	header("Location: /admin");

	exit;

});


/**
 * @Route /admin/logout
 * @method GET
 * @param Sem parametros
 * É chamado o method logout() para deslogar o usuario admin
 * @Route
 */
$app->get('/admin/logout', function() {

	User::logout();

	header("Location: /admin/login");

	exit;

});


/**
 * @Route /admin/forgot
 * @method GET
 * @param Sem parametros
 * Chama a pagina forgot - esqueci minha senha
 */
$app->get('/admin/forgot/', function() {

	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);
    
	$page->setTpl('forgot', array(

	));

});


/**
 * @Route /admin/forgot
 * @method POST
 * @param Sem parametros
 * Chama a pagina forgot - esqueci minha senha
 */
$app->post('/admin/forgot', function() {

	$user = User::getForgot($_POST['email']);

	if($user === true){
		header("Location: /admin/forgot/sent");
	}else{
		header("Location: /admin/forgot/failure");
	}
	exit;

});

$app->get('/admin/forgot/sent', function(){

	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);
    
	$page->setTpl('forgot-sent');

});

$app->get('/admin/forgot/failure', function(){

	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);
    
	$page->setTpl('forgot-sent-failure');

});

$app->get('/admin/forgot/reset', function(){

	if(!isset($_GET['code'])){
		header('Location: /admin');
		exit;
	}

	$user = User::validForgotDecrypt($_GET['code']);

	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);

	$page->setTpl('forgot-reset', array(
		"name"=>$user['desperson'],
		"code"=>$_GET['code']
	));

});

$app->post('/admin/forgot/reset', function(){


	if(!isset($_POST['code'])){
		header('Location: /admin');
		exit;
	}

	$forgot = User::validForgotDecrypt($_POST['code']);

	User::setForgotUsed($forgot['idrecovery']);

	$user = new User();

	$user->get((int)$forgot['iduser']);

	$password = User::encryptPassword($_POST['password']);

	$user->setPassword($password);

	$page = new PageAdmin([
		"header"=>false,
		"footer"=>false
	]);

	$page->setTpl('forgot-reset-success');

});

/**
 ****************************** OBSERVAÇÃO IMPORTANTE **************************************************
 *
 * A seguir todos as Route serão verificado se o usuário tem permissão de acesso a área Admin do Sistema
 * A função static verifyLogin da class User verifica se existe usuario com SESSAO setada.
 * 
 *******************************************************************************************************
 */


/**
 * @Route /admin/
 * @method GET
 * @param Sem parametros
 * A classe PageAdmin monta o layout com cabeçalho, corpo e rodapé do Backend e carrega a pagina index.php no corpo da página
 */
$app->get('/admin/', function() {

	User::verifyLogin();

	$page = new PageAdmin();
    
	$page->setTpl('index');
	
});



//===================================== INICIO DAS EXECUÇÃO DO CRUD CLASS Users =====================================//

/**
 * Route: /admin/users
 * @method GET
 * @param Sem parametros
 * A classe PageAdmin monta o layout listando todos os usuarios recebidos do banco
 */
$app->get('/admin/users', function() {

	User::verifyLogin();

	$users = User::listAll();

	$page = new PageAdmin();
    
	$page->setTpl('users', array(
		"users"=>$users
	));

});


/**
 * Route: /admin/users/create
 * @method GET
 * @param Sem parametros
 * A classe PageAdmin monta o layout com o template do formulário de criação do usuário
 */
$app->get('/admin/users/create', function() {

	User::verifyLogin();

	$page = new PageAdmin();
    
	$page->setTpl('users-create');

});

/**
 * Route: /admin/users/create
 * @method POST
 * @param Sem parametros
 * O Object $user seta todos os parametros da class User enviando a variável global $_POST
 * Em seguida, com as variaveis já setada, usa-se o method "save" para gravar os dados no BD
 */
$app->post('/admin/users/create', function() {

	User::verifyLogin();

	$user = new User();

	$_POST['inadmin'] = isset($_POST['inadmin']) ? 1 : 0;

	$user->setData($_POST);

	$user->save();

	header("Location: /admin/users");
	
	exit;

});


/**
 * Route: /admin/users/:iduser/delete
 * @method GET
 * @param $iduser 
 * A classe que disable o user apagando a senha cadastrada
 */
$app->get("/admin/users/:iduser/delete", function($iduser){

	User::verifyLogin();

	$user = new User();

	$user->get((int)$iduser);

	$user->delete();

	header("Location: /admin/users");

	exit;

});


/**
 * Route: /admin/users/:iduser
 * @method GET
 * @param iduser
 * Aqui usa-se o method "get" da class User para setar todos os campos da tabela no objeto $user 
 * Em seguida envia para o method "setTpl" que carrega o template html users-update, enviando as chaves e valores para imprimir nos campos do form
 */
$app->get('/admin/users/:iduser', function($iduser) {

	User::verifyLogin();

	$user = new User();

	$user->get((int)$iduser);

	$page = new PageAdmin();
    
	$page->setTpl('users-update', array(
		"user"=>$user->getValues()
	));

});

/**
 * Route: /admin/users/:iduser
 * @method POST
 * @param iduser
 * Aqui usa-se o method "get" da class User para setar todos os campos da tabela no objeto $user
 * Parece desnecessário setar todos os campos, mas não é, pois com ele é dados o start do array de chaves e values do BD para serem atualizados
 * Em seguida é atualizado o array com os novos valores digitados atraves do method setData enviando o parametro $_POST
 * Em seguida é chamado o method update() para gravar estes dados
 */
$app->post("/admin/users/:iduser", function($iduser){

	User::verifyLogin();

	$user = new User();

	$user->get((int)$iduser);

	$_POST['inadmin'] = isset($_POST['inadmin']) ? 1 : 0;

	$user->setData($_POST);

	$user->update();

	header("Location: /admin/users");

	exit;

});



//===================================== FIM DAS EXECUÇÃO DO CRUD CLASS Users =====================================//





//===================================== INICIO DAS EXECUÇÃO DO CRUD CLASS Categories =====================================//


/**
 * Route: /admin/categories
 * @method GET
 * @param Sem parametros
 * A classe PageAdmin monta o layout listando todas as categorias do banco
 */
$app->get("/admin/categories", function(){

	User::verifyLogin();

	$category = Category::listAll();

	$page = new PageAdmin();

	$page->setTpl("/admin/categories", array(
		"categories"=>$category
	));
});



/**
 * Route: /admin/categories/create
 * @method GET
 * @param Sem parametros
 * Monta a página para cadastrar categoria
 */
$app->get("/admin/categories/create", function(){

	User::verifyLogin();

	$page = new PageAdmin();

	$page->setTpl("/admin/categories-create");
});

/**
 * Route: /admin/categories/create
 * @method POST
 * @param Sem parametros
 * Monta a página para cadastrar categoria
 */
$app->post("/admin/categories/create", function(){

	User::verifyLogin();

	$category = new Category();

	$category->setData($_POST);

	$results = $category->save();

	header("Location: /admin/categories");

	exit;
});

/**
 * Route: /admin/categories/delete
 * @method POST
 * @param Sem parametros
 * Monta a página para cadastrar categoria
 */
$app->get("/admin/categories/:idcategory/delete", function($idcategory){

	User::verifyLogin();

	$category = new Category();

	$category->get((int)$idcategory);

	$category->delete();

	header("Location: /admin/categories");

	exit;
});


/**
 * Route: /admin/categories/enable
 * @method POST
 * @param Sem parametros
 * Monta a página para cadastrar categoria
 */
$app->get("/admin/categories/:idcategory/enable", function($idcategory){

	User::verifyLogin();

	$category = new Category();

	$category->get((int)$idcategory);

	$category->enable();  

	header("Location: /admin/categories");

	exit;
});


/**
 * Route: /admin/categories/:idcategory
 * @method GET
 * @param idcategory
 * Monta a página para alterar categoria
 */
$app->get("/admin/categories/:idcategory", function($idcategory){

	User::verifyLogin();

	$category = new Category();

	$category->get((int)$idcategory);

	$page = new PageAdmin();

	$page->setTpl("/admin/categories-update", array(
		"category"=>$category->getValues()
	));
});

/**
 * Route: /admin/categories/create
 * @method POST
 * @param Sem parametros
 * Monta a página para cadastrar categoria
 */
$app->post("/admin/categories/:idcategory", function($idcategory){

	User::verifyLogin();

	$category = new Category();

	$category->get((int)$idcategory);

	$category->setData($_POST);

	$results = $category->save();

	header("Location: /admin/categories");

	exit;
});






//===================================== FIM DAS EXECUÇÃO DO CRUD CLASS Categories =====================================//












//===================================== INICIO DAS EXECUÇÃO DO CRUD CLASS Products =====================================//


/**
 * Route: /admin/produts
 * @method GET
 * @param Sem parametros
 * A classe PageAdmin monta o layout listando todas as categorias do banco
 */
$app->get("/admin/products", function(){

	User::verifyLogin();

	$product = Product::listAll();

	$page = new PageAdmin();

	$page->setTpl("/admin/products", array(
		"products"=>$product
	));
});



/**
 * Route: /admin/products/create
 * @method GET
 * @param Sem parametros
 * Monta a página para cadastrar categoria
 */
$app->get("/admin/products/create", function(){

	User::verifyLogin();

	$page = new PageAdmin();

	$page->setTpl("/admin/products-create");
});

/**
 * Route: /admin/products/create
 * @method POST
 * @param Sem parametros
 * Monta a página para cadastrar categoria
 */
$app->post("/admin/products/create", function(){

	User::verifyLogin();

	$product = new Product();

	$product->setData($_POST);

	$results = $product->save();

	header("Location: /admin/products");

	exit;
});

/**
 * Route: /admin/products/delete
 * @method POST
 * @param Sem parametros
 * Monta a página para cadastrar categoria
 */
$app->get("/admin/products/:idproduct/delete", function($idproduct){

	User::verifyLogin();

	$product = new Product();

	$product->get((int)$idproduct);

	$product->delete();

	header("Location: /admin/products");

	exit;
});


/**
 * Route: /admin/products/:idproduct
 * @method GET
 * @param idproduct
 * Monta a página para alterar categoria
 */
$app->get("/admin/products/:idproduct", function($idproduct){

	User::verifyLogin();

	$product = new Product();

	$product->get((int)$idproduct);

	$page = new PageAdmin();

	$page->setTpl("/admin/products-update", array(
		"product"=>$product->getValues()
	));
});

/**
 * Route: /admin/products/create
 * @method POST
 * @param Sem parametros
 * Monta a página para cadastrar categoria
 */
$app->post("/admin/products/:idproduct", function($idproduct){

	User::verifyLogin();

	$product = new Product();

	$product->get((int)$idproduct);

	$product->setData($_POST);

	$results = $product->save();

	header("Location: /admin/products");

	exit;
});




/**
 * Route: /admin/products/:idproduct
 * @method GET
 * @param idproduct
 * Monta a página para alterar categoria
 */
$app->get("/admin/products/photos/:idproduct", function($idproduct){

	User::verifyLogin();

	$product = new Product();

	$product->get((int)$idproduct);

	$photos = $product->getPhotos((int)$idproduct);

	$page = new PageAdmin();

	$page->setTpl("/admin/products-photos", array(
		"product"=>$product->getValues(),
		"photos"=>$photos
	));
});



$app->post("/admin/products/photos/:idproduct", function($idproduct){

	User::verifyLogin();

	$product = new Product();

	$product->get((int)$idproduct);

	$file = isset($_FILES['file']) ? $_FILES['file'] : NULL;

	$product->addPhoto($file);

	header("Location: /admin/products/photos/$idproduct");

	exit;
});

$app->get("/admin/products/photos/:idproduct/:idphotos/delete", function($idproduct, $idphotos){

	User::verifyLogin();

	$product = new Product();

	$product->deletePhoto($idphotos);

	header("Location: /admin/products/photos/$idproduct");

	exit;
});



//===================================== FIM DAS EXECUÇÃO DO CRUD CLASS Products =====================================//









$app->run();

 ?>