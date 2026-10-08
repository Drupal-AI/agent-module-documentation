#!/usr/bin/env bash
# Execution VERIFY: PASS when a simple_sitemap_type 'dss_eval' exists with third-party setting
# domain_simple_sitemap.sitemap_domain == 'dss_eval' AND a simple_sitemap variant 'dss_eval'
# exists. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("simple_sitemap_type");
  $vs = \Drupal::entityTypeManager()->getStorage("simple_sitemap");
  $t = $ts->load("dss_eval");
  $tps = $t ? $t->getThirdPartySetting("domain_simple_sitemap","sitemap_domain") : NULL;
  $v = $vs->load("dss_eval");
  $ok = $t && ($tps === "dss_eval") && $v;
  print ($ok?"PASS":"FAIL")." type=".($t?"yes":"no")." sitemap_domain=".var_export($tps,TRUE)." variant=".($v?"yes":"no")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
