#!/usr/bin/env bash
# Execution VERIFY: PASS when pvm_task has paragraphs_viewmode_behavior enabled with a non-empty
# override_available and an override_default that is contained in override_available.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  $pt = ParagraphsType::load("pvm_task");
  $bp = $pt ? ($pt->get("behavior_plugins")["paragraphs_viewmode_behavior"] ?? NULL) : NULL;
  $enabled = $bp["enabled"] ?? FALSE;
  $avail = $bp["override_available"] ?? [];
  $default = $bp["override_default"] ?? NULL;
  $ok = ($enabled == TRUE) && !empty($avail) && $default !== NULL && in_array($default, $avail, TRUE);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " default=" . var_export($default, TRUE) . " avail=" . implode(",", (array) $avail) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
