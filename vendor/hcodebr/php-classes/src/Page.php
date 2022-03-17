<?php 

namespace Hcode;

use Rain\Tpl;

class Page {

	private $tpl;

	private $options = [];

	private $defaults = [
		"header"=>true,
		"footer"=>true,
		"data"=>[]
	];

	public function __construct($options = array(), $tpl_dir = "/views/")
	{
		//Importante a ordem dos arrays. Já que o ultimo array informado terá prevalencia sobre os anterioes
		$this->options = array_merge($this->defaults, $options);

		$config = array(
			"tpl_dir"       => $_SERVER['DOCUMENT_ROOT'].$tpl_dir,
			"cache_dir"     => $_SERVER['DOCUMENT_ROOT']."/views-cache/",
			"debug"         => false // set to false to improve the speed
		);

		Tpl::configure( $config );

		$this->tpl = new Tpl;

		$this->setData($this->options['data']);

		//Se pagina login, por exemplo, virá como false a variavel array header e não mostrará a pagina header
		if($this->options['header'] === true)
		{
			$this->tpl->draw("header");
		}

	}


	public function setData($data = array())
	{

		foreach ($data as $key => $value) {

			$this->tpl->assign($key, $value);

		}

	}

	public function setTpl($name, $data = array(), $returnHTML = false)
	{

		$this->setData($data);

		return $this->tpl->draw($name, $returnHTML);

	}

	

	public function __destruct()
	{

		//Se pagina login, por exemplo, virá como false a variavel array footer e não mostrará a pagina footer
		if($this->options['footer'] === true)
		{
			$this->tpl->draw("footer");
		}
		
	}

}