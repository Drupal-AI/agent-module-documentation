#!/usr/bin/env bash
# Execution VERIFY for "show the Discard changes button again, keep Revert hidden, and use
# Layout Builder's default post-save redirect".
# PASS when gin_lb.settings has hide_discard_button === FALSE, hide_revert_button === TRUE and
# save_behavior === 'default'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::configFactory()->get("gin_lb.settings");
  $discard = $c->get("hide_discard_button");
  $revert = $c->get("hide_revert_button");
  $save = $c->get("save_behavior");
  $ok = ($discard === FALSE) && ($revert === TRUE) && ($save === "default");
  print ($ok ? "PASS" : "FAIL")
        . " hide_discard_button=" . \var_export($discard, TRUE)
        . " hide_revert_button=" . \var_export($revert, TRUE)
        . " save_behavior=" . \var_export($save, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
