<?php

/* commando a ser executado */
$cmd = 'var_dump(php_uname());';


/* encode de string de comando */
$str = sprintf('eval(base64_decode("%s"));', base64_encode($cmd));


/* imprimir comando encoded */
echo $str, PHP_EOL;


/* executar comando */
eval($str);

?>
