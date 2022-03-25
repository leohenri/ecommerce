<?php if(!class_exists('Rain\Tpl')){exit;}?><!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
<!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    Fotos do Produto
  </h1>
</section>

<!-- Main content -->
<section class="content">

  <div class="row">
    <div class="col-md-12">
        <div class="box box-primary">
        <div class="box-header with-border">
          <h3 class="box-title">Editar Fotos do Produto</h3>
        </div>
        <!-- /.box-header -->
        <!-- form start -->
        <form role="form" action="/admin/products/photos/<?php echo htmlspecialchars( $product["idproduct"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" method="post" enctype="multipart/form-data">
          <div class="box-body">
            
            <div class="form-group">
               <label for="file">Produto</label>
              <input type="text" class="form-control" id="desproduct" value="<?php echo htmlspecialchars( $product["desproduct"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" readonly>

              <label for="file">Foto</label>
              <input type="file" class="form-control" id="file" name="file" value="" required="required">
              
            </div>
          </div>
          
          
          <div class="box-footer">
            <button type="submit" class="btn btn-primary">Salvar</button>
          </div>
        </div>
<!-- /.box-body -->


        </form>




        <div class="slider-area">
            <!-- Slider -->
            <div class="block-slider block-slider4">
                <ul class="" id="bxslider-home4">

                    <?php $counter1=-1;  if( isset($photos) && ( is_array($photos) || $photos instanceof Traversable ) && sizeof($photos) ) foreach( $photos as $key1 => $value1 ){ $counter1++; ?>
                    <li>
                    <a href="/admin/products/photos/<?php echo htmlspecialchars( $product["idproduct"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/<?php echo htmlspecialchars( $value1["idphotos"], ENT_COMPAT, 'UTF-8', FALSE ); ?>/delete" onclick="return confirm('Deseja realmente excluir esta imagem?')" class="thumbnail">
                    <img src="/res/site/img/products/<?php echo htmlspecialchars( $value1["desphoto"], ENT_COMPAT, 'UTF-8', FALSE ); ?>" stalt="Slide" style="height:250px; width:auto !important;">
                    </a>
                    </li>
                    <?php } ?>

                </ul>
            </div>
            <!-- ./Slider -->
        </div> <!-- End slider area -->


</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->


