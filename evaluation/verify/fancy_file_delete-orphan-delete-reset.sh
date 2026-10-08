#!/usr/bin/env bash
# Execution RESET for the "delete the orphaned managed file" task. Creates a KNOWN orphaned
# managed file so an un-built site verifies as FAIL (the file exists) and a correct build
# verifies as PASS (the file is gone). Orphan = managed file whose only file_usage reference
# is type=node pointing at a non-existent node (987654) -- exactly what ffd_orphan_filter
# matches, AND because a stale usage row is present a *normal* File::delete() refuses, so the
# agent must FORCE-delete (drush ffd <fid> --force, the module's batch service, or the FORCE
# VBO action). Marker filename ffd_eval_orphan_del.txt. Idempotent: clears prior state first.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $fs = \Drupal::service("file_system");
  foreach ($db->query("SELECT fid, uri FROM {file_managed} WHERE filename = :n", [":n" => "ffd_eval_orphan_del.txt"])->fetchAll() as $r) {
    @unlink($fs->realpath($r->uri));
    $db->delete("file_managed")->condition("fid", $r->fid)->execute();
    $db->delete("file_usage")->condition("fid", $r->fid)->execute();
  }
  file_put_contents($fs->realpath("public://") . "/ffd_eval_orphan_del.txt", "delete me");
  $file = \Drupal\file\Entity\File::create([
    "uri" => "public://ffd_eval_orphan_del.txt",
    "filename" => "ffd_eval_orphan_del.txt",
    "status" => 1,
  ]);
  $file->save();
  $db->insert("file_usage")->fields([
    "fid" => $file->id(), "module" => "file", "type" => "node", "id" => 987654, "count" => 1,
  ])->execute();
  print "MARK_RESET fid=" . $file->id() . "\n";
' 2>/dev/null | grep -a '^MARK_RESET'
drush cr >/dev/null 2>&1
echo "reset: created orphaned managed file ffd_eval_orphan_del.txt (must be force-deleted)"
