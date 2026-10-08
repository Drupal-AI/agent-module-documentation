#!/usr/bin/env bash
# Execution VERIFY: PASS when an HTMX Block "htmx_build2" exists wrapping the site branding
# block (system_branding_block). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\htmx\Entity\HtmxBlock;
  $b = HtmxBlock::load("htmx_build2");
  $plugin = $b ? $b->get("plugin") : "none";
  $ok = ($b && $plugin === "system_branding_block");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
