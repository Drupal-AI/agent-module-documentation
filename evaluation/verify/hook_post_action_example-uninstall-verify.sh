#!/usr/bin/env bash
# hook_post_action_example execution VERIFY (uninstall case): PASS when the module is NOT enabled and
# no longer an implementer, while parent hook_post_action IS still enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ex = \Drupal::moduleHandler()->moduleExists("hook_post_action_example");
  $parent = \Drupal::moduleHandler()->moduleExists("hook_post_action");
  $impl = [];
  \Drupal::moduleHandler()->invokeAllWith("entity_postinsert", function($cb, $mod) use (&$impl) { $impl[] = $mod; });
  $ok = (!$ex) && $parent && !in_array("hook_post_action_example", $impl, TRUE);
  print ($ok ? "PASS" : "FAIL") . " example=" . var_export($ex, TRUE) . " parent=" . var_export($parent, TRUE) . " implementers=" . json_encode($impl) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
