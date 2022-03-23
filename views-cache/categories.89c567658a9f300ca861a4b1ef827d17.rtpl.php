<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Lista de Categorias
  </h1>
  <ol class="breadcrumb">
    <li><a href="/admin"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active"><a href="/admin/categories">Categorias</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
  	<div class="col-md-12">
  		<div class="box box-primary">
            
            <div class="box-header">
              <a href="/admin/categories/create" class="btn btn-success">Cadastrar Categoria</a>
            </div>

            <div class="box-body no-padding">
              <table class="table table-striped">
                <thead>
                  <tr>
                    <th style="width: 10px">#</th>
                    <th>Nome da Categoria</th>
                    <th>Atualizado em</th>
                    <th style="width: 200px">&nbsp;</th>
                  </tr>
                </thead>
                <tbody>
                  <?php $counter1=-1;  if( isset($categories) && ( is_array($categories) || $categories instanceof Traversable ) && sizeof($categories) ) foreach( $categories as $key1 => $value1 ){ $counter1++; ?>

                  <tr>
                    <td><?php echo htmlspecialchars( $value1["idcategory"], ENT_COMPAT, 'UTF-8', FALSE ); ?></td>
                    <td><?php echo htmlspecialchars( $value1["descategory"], ENT_COMPAT, 'UTF-8', FALSE ); ?> <?php if( $value1["disablecategory"]==1 ){ ?><b>(Inativo)</b><?php } ?></td>
                    <td><?php if( $value1["dtlastupdate"]!=NULL ){ ?><?php echo htmlspecialchars( $value1["dtlastupdate"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php }else{ ?><?php echo htmlspecialchars( $value1["dtregister"], ENT_COMPAT, 'UTF-8', FALSE ); ?><?php } ?></td>
                    <td>
                      <a href="/admin/categories/<?php echo htmlspecialchars( $value1["idcategory"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" class="btn btn-primary btn-xs"><i class="fa fa-edit"></i> Editar</a>
                      
                      <?php if( $value1["disablecategory"]==1 ){ ?>

                      
                      <a href="/admin/categories/<?php echo htmlspecialchars( $value1["idcategory"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/enable" onclick="return confirm('Essa categoria será reativada. Confirma?')" class="btn btn-success btn-xs"><i class="fa fa-trash"></i> Reativar</a>
                      
                      <?php }else{ ?>


                      <a href="/admin/categories/<?php echo htmlspecialchars( $value1["idcategory"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete" onclick="return confirm('Deseja realmente DESATIVAR esta categoria? Você confirma?')" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> Desativar</a>
                      
                      <?php } ?>


                    </td>
                  </tr>
                  <?php } ?>

                </tbody>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
  	</div>
  </div>

</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->