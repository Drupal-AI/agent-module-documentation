#!/usr/bin/env bash
# Execution VERIFY: PASS when embedded_content button 'ec_task' exists with label 'EC Task' and
# settings.label_singular == 'component'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\embedded_content\Entity\EmbeddedContentButton;
  $e = EmbeddedContentButton::load("ec_task");
  $label = $e ? (string) $e->label() : "none";
  $sing = $e ? (string) ($e->getSetting("label_singular") ?? "") : "";
  $ok = ($e && $label === "EC Task" && $sing === "component");
  print ($ok ? "PASS" : "FAIL") . " label=" . $label . " label_singular=" . $sing . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
