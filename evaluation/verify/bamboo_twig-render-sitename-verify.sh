#!/usr/bin/env bash
# Execution VERIFY: render the agent's template and PASS when its output contains the live site name.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_parent_sitename.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else {
    $expected = (string) \Drupal::config("system.site")->get("name");
    try {
      $tpl = \Drupal::service("twig")->createTemplate(file_get_contents($f));
      $r = (string) $tpl->render([]);
      $ok = ($expected !== "" && strpos($r, $expected) !== FALSE);
      print ($ok ? "PASS" : "FAIL") . " expected=" . $expected . " output=" . trim(preg_replace("/\s+/"," ",$r)) . "\n";
    } catch (\Throwable $e) { print "FAIL render-error: ".$e->getMessage()."\n"; }
  }
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
