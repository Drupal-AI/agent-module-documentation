<?php
/**
 * Remove "ghost" field storage definitions that break node save/delete site-wide.
 *
 * A botched agent cleanup can drop a field's DB table and delete its config while leaving
 * the field in the entity type's *installed* field-storage-definition tracking
 * (key_value 'entity.definitions.installed' -> 'node.field_storage_definitions'). The
 * entity storage then iterates that ghost definition on every save/delete and fatals with
 * "Base table ... doesn't exist".
 *
 * This uninstalls each named ghost definition through the EntityDefinitionUpdateManager
 * (which drops tables only if present and clears the tracking). If the manager has no
 * handle on it, we strip it straight out of the installed-definitions key_value store.
 *
 * Pass field names as args:
 *   ddev drush php:script .../fix-ghost-fields.php -- field_ltgt_url field_rofw_on field_rofw_off
 * With no args it auto-detects node fields whose data table is missing.
 */

$entity_type = 'node';
$edum = \Drupal::entityDefinitionUpdateManager();
$kv = \Drupal::keyValue('entity.definitions.installed');
$key = $entity_type . '.field_storage_definitions';
$installed = $kv->get($key, []);

// Known ghost fields plus auto-detection of any others.
$names = ['field_ltgt_url', 'field_rofw_on', 'field_rofw_off'];
{
  // Auto-detect: installed defs whose base data table is missing.
  $schema = \Drupal::database()->schema();
  foreach ($installed as $name => $def) {
    $table = $entity_type . '__' . $name;
    if (strpos($name, 'field_') === 0 && !$schema->tableExists($table)) {
      // Only flag if there is no live config backing it (a real field has its table).
      if (!\Drupal::config('field.storage.' . $entity_type . '.' . $name)->get('type')) {
        $names[] = $name;
      }
    }
  }
}

if (!$names) { print "no ghost fields detected\n"; return; }
print "targets: " . implode(', ', $names) . "\n";

foreach ($names as $name) {
  $def = $edum->getFieldStorageDefinition($name, $entity_type);
  if ($def) {
    try {
      $edum->uninstallFieldStorageDefinition($def);
      print "uninstalled via manager: $name\n";
      continue;
    }
    catch (\Throwable $e) {
      print "manager uninstall failed for $name (" . substr($e->getMessage(), 0, 60) . "), stripping key_value\n";
    }
  }
  // Fallback: strip straight out of installed-definitions tracking.
  $installed = $kv->get($key, []);
  if (isset($installed[$name])) {
    unset($installed[$name]);
    $kv->set($key, $installed);
    print "stripped from installed defs: $name\n";
  }
  else {
    print "not present: $name\n";
  }
}

drupal_flush_all_caches();
print "caches flushed\n";
