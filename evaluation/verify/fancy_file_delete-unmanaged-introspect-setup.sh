#!/usr/bin/env bash
# Introspection SETUP for fancy_file_delete: seed a KNOWN *unmanaged* file so the agent has
# something to discover. An "unmanaged" file (per UnmanagedFilesService) is a file present on
# disk in the files directory but ABSENT from the file_managed table. We write
# public://ffd_eval_unmanaged.txt straight to disk and create NO file_managed row. Cleanup
# removes it. Deprecation notices leak to stdout, so we tag our output.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $fs = \Drupal::service("file_system");
  // Ensure no stray file_managed row claims the marker (keep it truly unmanaged).
  foreach ($db->query("SELECT fid FROM {file_managed} WHERE filename = :n", [":n" => "ffd_eval_unmanaged.txt"])->fetchAll() as $r) {
    $db->delete("file_managed")->condition("fid", $r->fid)->execute();
    $db->delete("file_usage")->condition("fid", $r->fid)->execute();
  }
  file_put_contents($fs->realpath("public://") . "/ffd_eval_unmanaged.txt", "eval unmanaged payload");
  print "MARK_SETUP path=public://ffd_eval_unmanaged.txt\n";
' 2>/dev/null | grep -a '^MARK_SETUP'
drush cr >/dev/null 2>&1
echo "setup: seeded unmanaged file public://ffd_eval_unmanaged.txt (on disk, not in file_managed)"
