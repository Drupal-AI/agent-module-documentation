#!/usr/bin/env bash
# PASS when output contains the current 4-digit year (from a date token).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_token_render_year.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else { $y=date("Y"); try { $tpl=\Drupal::service("twig")->createTemplate(file_get_contents($f)); $r=(string)$tpl->render([]); $ok=(strpos($r,$y)!==FALSE); print ($ok?"PASS":"FAIL")." year=".$y." output=".trim(preg_replace("/\s+/"," ",$r))."\n"; } catch (\Throwable $ex){ print "FAIL render-error: ".$ex->getMessage()."\n"; } }
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
