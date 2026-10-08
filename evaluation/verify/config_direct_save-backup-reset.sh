#!/usr/bin/env bash
# Execution RESET (also CLEANUP): remove any timestamped backup copies of the config sync
# directory (siblings named <sync-basename>-*), WITHOUT touching the real sync directory.
# So verify FAILS until a backup is created. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Site\Settings;
  $dir = Settings::get("config_sync_directory");
  $abs = str_starts_with($dir, "/") ? $dir : DRUPAL_ROOT . "/" . $dir;
  $parent = dirname($abs);
  $base = basename($abs);
  foreach (glob($parent . "/" . $base . "-*", GLOB_ONLYDIR) as $bdir) {
    $it = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($bdir, FilesystemIterator::SKIP_DOTS), RecursiveIteratorIterator::CHILD_FIRST);
    foreach ($it as $f) { $f->isDir() ? @rmdir($f->getPathname()) : @unlink($f->getPathname()); }
    @rmdir($bdir);
  }
  $n = count(glob($parent . "/" . $base . "-*", GLOB_ONLYDIR));
  print "reset: sync backup dirs remaining=" . $n . "\n";
' 2>/dev/null
echo "reset: removed any sync-* backup directories (real sync dir untouched)"
