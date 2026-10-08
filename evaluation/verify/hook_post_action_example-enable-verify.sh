#!/usr/bin/env bash
# hook_post_action_example execution VERIFY (enable case): PASS when the module is enabled AND is an
# implementer of hook_entity_postinsert. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("hook_post_action_example");
  $impl = [];
  \Drupal::moduleHandler()->invokeAllWith("entity_postinsert", function($cb, $mod) use (&$impl) { $impl[] = $mod; });
  $ok = $enabled && in_array("hook_post_action_example", $impl, TRUE);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " implementers=" . json_encode($impl) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
