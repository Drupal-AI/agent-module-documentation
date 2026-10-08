#!/usr/bin/env bash
# Execution VERIFY: render the agent's Twig template and PASS when output contains "core/themes/olivero".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_path_render_theme.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else { try { $tpl=\Drupal::service("twig")->createTemplate(file_get_contents($f)); $r=(string)$tpl->render([]); $ok=(strpos($r,"core/themes/olivero")!==FALSE); print ($ok?"PASS":"FAIL")." output=".trim(preg_replace("/\s+/"," ",$r))."\n"; } catch (\Throwable $e){ print "FAIL render-error: ".$e->getMessage()."\n"; } }
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
