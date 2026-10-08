#!/usr/bin/env bash
# Introspection CLEANUP for fancy_file_delete: remove the unmanaged file seeded by
# fancy_file_delete-unmanaged-introspect-setup.sh (marker public://ffd_eval_unmanaged.txt) --
# deletes it from disk and clears any matching unmanaged_files entity row the module may have
# recorded. Leaves real files untouched. Safe to run repeatedly.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $fs = \Drupal::service("file_system");
  @unlink($fs->realpath("public://") . "/ffd_eval_unmanaged.txt");
  if ($db->schema()->tableExists("unmanaged_files")) {
    $db->delete("unmanaged_files")->condition("path", "public://ffd_eval_unmanaged.txt")->execute();
  }
  print "MARK_CLEAN\n";
' 2>/dev/null | grep -a '^MARK_CLEAN' >/dev/null
drush cr >/dev/null 2>&1
echo "cleanup: removed public://ffd_eval_unmanaged.txt (disk + unmanaged_files row)"
