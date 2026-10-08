#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_token_render_sitename.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else { $e=(string)\Drupal::config("system.site")->get("name"); try { $tpl=\Drupal::service("twig")->createTemplate(file_get_contents($f)); $r=(string)$tpl->render([]); $ok=($e!==""&&strpos($r,$e)!==FALSE); print ($ok?"PASS":"FAIL")." expected=".$e." output=".trim(preg_replace("/\s+/"," ",$r))."\n"; } catch (\Throwable $ex){ print "FAIL render-error: ".$ex->getMessage()."\n"; } }
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
