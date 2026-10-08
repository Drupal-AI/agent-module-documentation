#!/usr/bin/env bash
# Execution VERIFY: PASS when webform srw_task has a handler whose plugin id is simple_recaptcha. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("srw_task");
  $ok = FALSE;
  if ($w) {
    foreach ($w->getHandlers() as $h) {
      if ($h->getPluginId() === "simple_recaptcha") { $ok = TRUE; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " webform=" . ($w ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
