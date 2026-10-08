#!/usr/bin/env bash
# Execution VERIFY: PASS when webform weh_task has a handler with plugin id
# webform_entity_handler whose settings.entity_type_id is node:article.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("weh_task");
  $ok = FALSE; $found = "none";
  if ($w) {
    foreach ($w->getHandlers() as $h) {
      if ($h->getPluginId() === "webform_entity_handler") {
        $et = $h->getSettings()["entity_type_id"] ?? "";
        $found = $et;
        if ($et === "node:article") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " entity_type_id=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
