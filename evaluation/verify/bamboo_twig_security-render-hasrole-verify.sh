#!/usr/bin/env bash
# PASS when the agent template correctly prints HASROLE/NOROLE for whether user 1 has the
# 'administrator' role, matching the live computed answer, via bamboo_has_role.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_security_render_hasrole.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else {
    $exp = \Drupal\user\Entity\User::load(1)->hasRole("administrator") ? "HASROLE" : "NOROLE";
    try { $tpl=\Drupal::service("twig")->createTemplate(file_get_contents($f)); $r=(string)$tpl->render([]);
      $ok=(strpos($r,$exp)!==FALSE);
      print ($ok?"PASS":"FAIL")." expected=".$exp." output=".trim(preg_replace("/\s+/"," ",$r))."\n";
    } catch (\Throwable $e){ print "FAIL render-error: ".$e->getMessage()."\n"; }
  }
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
