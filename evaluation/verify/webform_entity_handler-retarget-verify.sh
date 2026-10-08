#!/usr/bin/env bash
# Execution VERIFY: PASS when the webform_entity_handler on weh_retarget now targets node:page.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("weh_retarget");
  $found = "none"; $ok = FALSE;
  if ($w) {
    foreach ($w->getHandlers() as $h) {
      if ($h->getPluginId() === "webform_entity_handler") {
        $found = $h->getSettings()["entity_type_id"] ?? "";
        if ($found === "node:page") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " entity_type_id=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
