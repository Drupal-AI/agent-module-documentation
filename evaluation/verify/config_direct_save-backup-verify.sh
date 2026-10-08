#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one timestamped backup copy of the sync directory
# exists (sibling <sync-basename>-*) AND it contains system.site.yml. Prints PASS/FAIL;
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Site\Settings;
  $dir = Settings::get("config_sync_directory");
  $abs = str_starts_with($dir, "/") ? $dir : DRUPAL_ROOT . "/" . $dir;
  $parent = dirname($abs);
  $base = basename($abs);
  $found = "";
  foreach (glob($parent . "/" . $base . "-*", GLOB_ONLYDIR) as $bdir) {
    if (is_file($bdir . "/system.site.yml")) { $found = $bdir; break; }
  }
  $ok = $found !== "";
  print ($ok ? "PASS" : "FAIL") . " backup_dir=" . ($found ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
