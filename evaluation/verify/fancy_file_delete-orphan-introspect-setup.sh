#!/usr/bin/env bash
# Introspection SETUP for fancy_file_delete: seed a KNOWN orphaned managed file so the agent
# has something to discover. An "orphan" (per the module's ffd_orphan_filter query) is a
# managed file whose only file_usage reference is a `node` that no longer exists. We create a
# physical file public://ffd_eval_orphan.txt, a matching file_managed entity, and a file_usage
# row of type=node pointing at a non-existent nid (987654). The marker filename lets cleanup
# remove exactly this file. Deprecation notices leak to stdout, so we tag our output.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $fs = \Drupal::service("file_system");
  // Remove any leftover from a previous run.
  foreach ($db->query("SELECT fid, uri FROM {file_managed} WHERE filename = :n", [":n" => "ffd_eval_orphan.txt"])->fetchAll() as $r) {
    @unlink($fs->realpath($r->uri));
    $db->delete("file_managed")->condition("fid", $r->fid)->execute();
    $db->delete("file_usage")->condition("fid", $r->fid)->execute();
  }
  // Create the physical file + managed entity.
  file_put_contents($fs->realpath("public://") . "/ffd_eval_orphan.txt", "eval orphan payload");
  $file = \Drupal\file\Entity\File::create([
    "uri" => "public://ffd_eval_orphan.txt",
    "filename" => "ffd_eval_orphan.txt",
    "status" => 1,
  ]);
  $file->save();
  // Register a usage row against a node that does not exist -> makes it an orphan.
  $db->insert("file_usage")->fields([
    "fid" => $file->id(), "module" => "file", "type" => "node", "id" => 987654, "count" => 1,
  ])->execute();
  print "MARK_SETUP fid=" . $file->id() . "\n";
' 2>/dev/null | grep -a '^MARK_SETUP'
drush cr >/dev/null 2>&1
echo "setup: seeded orphaned managed file public://ffd_eval_orphan.txt (usage -> nonexistent node 987654)"
