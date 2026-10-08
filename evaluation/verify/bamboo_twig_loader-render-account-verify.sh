#!/usr/bin/env bash
# PASS when the agent template renders (contains) the account name 'bamboo_render_user_71'.
# Rendered inside a RenderContext so both scalar (load_entity().getAccountName()) and render-array
# (bamboo_render_field) approaches work.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_loader_render_account.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else { try {
      $tpl=\Drupal::service("twig")->createTemplate(file_get_contents($f));
      $ctx=new \Drupal\Core\Render\RenderContext();
      $r=(string) \Drupal::service("renderer")->executeInRenderContext($ctx, function() use ($tpl){ return $tpl->render([]); });
      $ok=(strpos($r,"bamboo_render_user_71")!==FALSE);
      print ($ok?"PASS":"FAIL")." output=".trim(preg_replace("/\s+/"," ",substr($r,0,200)))."\n";
    } catch (\Throwable $e){ print "FAIL render-error: ".$e->getMessage()."\n"; } }
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
