#!/usr/bin/env bash
# Execution VERIFY for "exempt system.maintenance and every views.view.* from the lock".
# PASS when the LIVE site reports both patterns through the module's own whitelist hook
# (Settings::get('config_readonly_whitelist_patterns') feeds
# config_readonly_config_readonly_whitelist_patterns()), and the wildcard pattern really
# matches views.view.frontpage under the module's matching rules.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $patterns = \Drupal::moduleHandler()->invokeAll("config_readonly_whitelist_patterns") ?: [];
  $patterns = array_values(array_filter((array) $patterns, "is_string"));

  $matches = function (string $name) use ($patterns): bool {
    foreach ($patterns as $pattern) {
      $escaped = str_replace("\\*", ".*", preg_quote($pattern, "/"));
      if (preg_match("/^" . $escaped . "$/", $name)) {
        return TRUE;
      }
    }
    return FALSE;
  };

  $maintenance = $matches("system.maintenance");
  $views_one = $matches("views.view.frontpage");
  $views_two = $matches("views.view.content");
  // Must not be a blanket "*" that whitelists everything.
  $not_blanket = !$matches("system.site");

  $ok = $maintenance && $views_one && $views_two && $not_blanket;
  print ($ok ? "PASS" : "FAIL")
    . " patterns=" . json_encode($patterns)
    . " maintenance=" . var_export($maintenance, TRUE)
    . " views=" . var_export($views_one && $views_two, TRUE)
    . " not_blanket=" . var_export($not_blanket, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
