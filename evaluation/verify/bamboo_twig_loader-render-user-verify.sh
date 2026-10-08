#!/usr/bin/env bash
# PASS when the agent template renders user 1's account name (matches the live username).
# Rendered inside a RenderContext so both scalar and render-array approaches work.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_loader_render_user.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else { $e=\Drupal\user\Entity\User::load(1)->getAccountName(); try {
      $tpl=\Drupal::service("twig")->createTemplate(file_get_contents($f));
      $ctx=new \Drupal\Core\Render\RenderContext();
      $r=(string) \Drupal::service("renderer")->executeInRenderContext($ctx, function() use ($tpl){ return $tpl->render([]); });
      $ok=($e!==""&&strpos($r,$e)!==FALSE);
      print ($ok?"PASS":"FAIL")." expected=".$e." output=".trim(preg_replace("/\s+/"," ",substr($r,0,200)))."\n";
    } catch (\Throwable $ex){ print "FAIL render-error: ".$ex->getMessage()."\n"; } }
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
