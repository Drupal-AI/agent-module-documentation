<?php
// Remove orphaned ghost node field storage definitions that break node delete/save site-wide.
// A "ghost" = a field_<name> entry in node.field_storage_definitions (installed defs key_value)
// whose dedicated table node__field_<name> does NOT exist AND which has no
// field.storage.node.field_<name> config entity. These are fixture remnants left by eval agents
// after a failed/partial cleanup; Drupal tries to read their missing table on every node write.
// Base fields (no dedicated table) are never touched — we only consider field_* names that both
// lack a table and lack a storage config.

$db  = \Drupal::database();
$cfg = \Drupal::configFactory();
$kvName = 'entity.definitions.installed';
$kv = \Drupal::keyValue($kvName);
$defs = $kv->get('node.field_storage_definitions');
if (!is_array($defs)) { echo "no node field_storage_definitions\n"; return; }

$removed = [];
foreach ($defs as $name => $def) {
  if (strpos($name, 'field_') !== 0) continue;              // only custom-style fields
  $table = 'node__' . $name;
  $hasTable  = $db->schema()->tableExists($table);
  $hasConfig = (bool) $cfg->get('field.storage.node.' . $name)->get('id');
  if (!$hasTable && !$hasConfig) {
    unset($defs[$name]);
    // also drop any stale storage-schema key
    $ss = \Drupal::keyValue('entity.storage_schema.sql');
    foreach ($ss->getAll() as $k => $v) {
      if (strpos($k, 'node.field.' . $name) !== false || strpos($k, $table) !== false) $ss->delete($k);
    }
    $removed[] = $name;
  }
}
if ($removed) {
  $kv->set('node.field_storage_definitions', $defs);
  echo "removed ghost node fields: " . implode(', ', $removed) . "\n";
} else {
  echo "no ghost node fields found\n";
}
