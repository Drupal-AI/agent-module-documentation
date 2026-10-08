#!/usr/bin/env bash
# Execution VERIFY: PASS when paragraph type so_task has the style_options behavior enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  $pt = ParagraphsType::load("so_task");
  $enabled = $pt ? array_keys($pt->getEnabledBehaviorPlugins()) : [];
  $ok = $pt && in_array("style_options", $enabled, TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . ($pt ? "yes" : "no") . " enabled=[" . implode(",", $enabled) . "]";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
