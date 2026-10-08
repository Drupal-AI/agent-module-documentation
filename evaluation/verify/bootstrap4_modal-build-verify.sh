#!/usr/bin/env bash
# Execution VERIFY: PASS when an entity browser "b4m_build" exists whose display plugin is
# bootstrap4_modal. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\entity_browser\Entity\EntityBrowser;
  $eb = EntityBrowser::load("b4m_build");
  $disp = $eb ? $eb->get("display") : "none";
  $ok = ($eb && $disp === "bootstrap4_modal");
  print ($ok ? "PASS" : "FAIL") . " display=" . $disp . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
