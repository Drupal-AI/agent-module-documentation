#!/usr/bin/env bash
# Execution VERIFY: PASS when media type mc_task_type exists, uses the media_crowdriff source,
# and has a string_long source field. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $t = MediaType::load("mc_task_type");
  $ok = FALSE; $src = "none"; $ft = "none";
  if ($t) {
    $src = $t->getSource()->getPluginId();
    $def = $t->getSource()->getSourceFieldDefinition($t);
    $ft = $def ? $def->getType() : "none";
    $ok = ($src === "media_crowdriff" && $ft === "string_long");
  }
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . " sourcefield_type=" . $ft . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
