<?php
/**
 * Force-clear orphaned "deleted" field storages that block field_purge_batch()
 * and thereby break Node::delete() site-wide.
 *
 * Eval agents create and delete namespaced test fields. Normally field_purge_batch()
 * cleans them up, but if one deleted field's data table is already gone,
 * field_purge_batch() throws on it and NONE of the pending deletions complete — so the
 * backlog grows and any entity delete that touches a deleted field storage fatals with
 * "Base table ... doesn't exist".
 *
 * All such fields here are throwaway test data, so this clears the backlog decisively:
 *  1. Try the normal purge first (drops real tables cleanly).
 *  2. Whatever remains is blocked by a missing table — drop any leftover
 *     field_deleted_data_* / field_deleted_revision_* tables, then remove the tracking
 *     entries from the deleted-fields repository so nothing references them again.
 *
 * Run:  ddev drush php:script agent-module-documentation/scripts/purge-deleted-fields.php
 */

use Drupal\Core\Database\Database;

$repo = \Drupal::service('entity_field.deleted_fields_repository');
$db = \Drupal::database();
$schema = $db->schema();

$before = count($repo->getFieldStorageDefinitions()) + count($repo->getFieldDefinitions());
print "deleted-defs before: $before\n";

// 1. Normal purge for everything whose tables still exist.
for ($i = 0; $i < 50; $i++) {
  try {
    field_purge_batch(100);
  }
  catch (\Throwable $e) {
    print "purge stopped (expected, missing table): " . substr($e->getMessage(), 0, 80) . "\n";
    break;
  }
  if (!($repo->getFieldStorageDefinitions() || $repo->getFieldDefinitions())) {
    break;
  }
}

// 2. Force-clear whatever is left (blocked by a missing data table).
foreach ($repo->getFieldDefinitions() as $d) {
  $repo->removeFieldDefinition($d);
  print "force-removed field def: " . $d->getTargetEntityTypeId() . "." . $d->getName() . "\n";
}
foreach ($repo->getFieldStorageDefinitions() as $d) {
  // Drop any lingering deleted-data tables for this storage, ignoring absence.
  foreach (['field_deleted_data_', 'field_deleted_revision_'] as $prefix) {
    $table = $prefix . substr(hash('sha256', $d->getUniqueStorageIdentifier()), 0, 10);
    // The real table name uses a module-computed hash; rather than reproduce it, sweep
    // by pattern below. This best-effort drop is a no-op if the name doesn't match.
    if ($schema->tableExists($table)) {
      $schema->dropTable($table);
      print "dropped $table\n";
    }
  }
  $repo->removeFieldStorageDefinition($d);
  print "force-removed storage def: " . $d->getTargetEntityTypeId() . "." . $d->getName() . "\n";
}

// 3. Sweep any remaining orphan field_deleted_* tables (their tracking is gone now).
foreach ($db->query("SHOW TABLES LIKE 'field_deleted_%'")->fetchCol() as $t) {
  $schema->dropTable($t);
  print "swept orphan table $t\n";
}

$after = count($repo->getFieldStorageDefinitions()) + count($repo->getFieldDefinitions());
print "deleted-defs after: $after\n";
