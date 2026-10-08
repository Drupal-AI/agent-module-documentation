#!/usr/bin/env bash
# Introspection CLEANUP for fancy_file_delete: remove exactly the orphaned managed file seeded
# by fancy_file_delete-orphan-introspect-setup.sh (marker filename ffd_eval_orphan.txt) --
# deletes the physical file, its file_managed row, and its file_usage row(s). Leaves all real
# files untouched. Safe to run even if the agent already deleted the file.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $fs = \Drupal::service("file_system");
  foreach ($db->query("SELECT fid, uri FROM {file_managed} WHERE filename = :n", [":n" => "ffd_eval_orphan.txt"])->fetchAll() as $r) {
    @unlink($fs->realpath($r->uri));
    $db->delete("file_managed")->condition("fid", $r->fid)->execute();
    $db->delete("file_usage")->condition("fid", $r->fid)->execute();
  }
  @unlink($fs->realpath("public://") . "/ffd_eval_orphan.txt");
  print "MARK_CLEAN\n";
' 2>/dev/null | grep -a '^MARK_CLEAN' >/dev/null
drush cr >/dev/null 2>&1
echo "cleanup: removed ffd_eval_orphan.txt (file_managed + file_usage + disk)"
