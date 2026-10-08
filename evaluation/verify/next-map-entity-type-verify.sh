#!/usr/bin/env bash
# next execution VERIFY: PASS when next_entity_type_config node.page exists with site_resolver
# = site_selector, configuration.sites contains nextzz_map, and revalidator = path.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\next\Entity\NextEntityTypeConfig;
  $c = NextEntityTypeConfig::load("node.page");
  if (!$c) { print "FAIL no-config\n"; return; }
  $resolver = $c->get("site_resolver");
  $reval = $c->get("revalidator");
  $sites = $c->get("configuration")["sites"] ?? [];
  $ok = ($resolver === "site_selector") && ($reval === "path") && in_array("nextzz_map", $sites, TRUE);
  print (($ok) ? "PASS" : "FAIL") . " site_resolver=" . var_export($resolver, TRUE) . " revalidator=" . var_export($reval, TRUE) . " sites=" . json_encode($sites) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
