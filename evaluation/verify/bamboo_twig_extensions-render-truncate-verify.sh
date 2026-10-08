#!/usr/bin/env bash
# PASS when the agent template truncates 'Hello World Foo Bar' to length 8 -> 'Hello Wo...'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_extensions_render_truncate.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else { try { $tpl=\Drupal::service("twig")->createTemplate(file_get_contents($f)); $r=(string)$tpl->render([]); $ok=(strpos($r,"Hello Wo...")!==FALSE); print ($ok?"PASS":"FAIL")." output=".trim(preg_replace("/\s+/"," ",$r))."\n"; } catch (\Throwable $e){ print "FAIL render-error: ".$e->getMessage()."\n"; } }
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
