#!/usr/bin/env bash
# Execution RESET: clear the file_import hard-case baseline so each run is independent.
# Deletes the `mf_eval_file_import` migration config entity if present (and any file entity
# left in the eval destination), then rebuilds caches. No arguments. Paths rel. to /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($m = \Drupal::entityTypeManager()->getStorage("migration")->load("mf_eval_file_import")) { $m->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => "public://eval-file-import/druplicon.png"]) as $f) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: migration mf_eval_file_import cleared"
