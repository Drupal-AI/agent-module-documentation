#!/usr/bin/env bash
# Execution VERIFY for "cr_eval_whitelist module supplies whitelist patterns via the hook".
# PASS when: the module cr_eval_whitelist is installed, it is one of the modules
# implementing hook_config_readonly_whitelist_patterns(), and the aggregated patterns
# returned by the live module handler contain 'cr_eval.settings' — while settings.php does
# NOT provide it (so the pattern really comes from the hook).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $mh = \Drupal::moduleHandler();
  $installed = $mh->moduleExists("cr_eval_whitelist");

  $implementors = [];
  $mh->invokeAllWith("config_readonly_whitelist_patterns", function ($hook, string $module) use (&$implementors) {
    $implementors[] = $module;
  });
  $from_hook = in_array("cr_eval_whitelist", $implementors, TRUE);

  $patterns = (array) ($mh->invokeAll("config_readonly_whitelist_patterns") ?: []);
  $has_pattern = in_array("cr_eval.settings", $patterns, TRUE);

  $from_settings = in_array("cr_eval.settings", (array) (\Drupal\Core\Site\Settings::get("config_readonly_whitelist_patterns") ?: []), TRUE);

  $ok = $installed && $from_hook && $has_pattern && !$from_settings;
  print ($ok ? "PASS" : "FAIL")
    . " installed=" . var_export($installed, TRUE)
    . " implementors=" . json_encode($implementors)
    . " patterns=" . json_encode(array_values($patterns))
    . " from_settings=" . var_export($from_settings, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
