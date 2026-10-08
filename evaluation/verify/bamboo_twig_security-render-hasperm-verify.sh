#!/usr/bin/env bash
# PASS when the agent template prints YES/NO for bamboo_has_permission('administer site configuration', 1)
# matching the live computed answer.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_security_render_hasperm.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else {
    $exp = \Drupal\user\Entity\User::load(1)->hasPermission("administer site configuration") ? "YES" : "NO";
    try { $tpl=\Drupal::service("twig")->createTemplate(file_get_contents($f)); $r=(string)$tpl->render([]);
      // match whole-word YES/NO to avoid NO matching inside other text
      $ok = preg_match("/\\b".$exp."\\b/", $r);
      print ($ok?"PASS":"FAIL")." expected=".$exp." output=".trim(preg_replace("/\s+/"," ",$r))."\n";
    } catch (\Throwable $e){ print "FAIL render-error: ".$e->getMessage()."\n"; }
  }
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
