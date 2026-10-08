#!/usr/bin/env bash
# Execution VERIFY: PASS when label_help_test is installed AND the node type
# test_label_help_core_fields exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("label_help_test");
  $nt = \Drupal\node\Entity\NodeType::load("test_label_help_core_fields");
  $ok = ($enabled && $nt);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . ($enabled ? "yes" : "no") . " content_type=" . ($nt ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
