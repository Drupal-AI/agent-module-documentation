<?php
// Disable the contrib `plugin` module at config level. Its PluginDefinitionConverter
// fatals (null definition) during every route rebuild at kernel terminate, discarding
// command stdout (silent-FAIL hazard for eval verify scripts). It has no dependents.
// Rip it out of core.extension + system.schema; a plain uninstall can't run because the
// uninstall's own route rebuild hits the same fatal.

$module = 'plugin';
$ext = \Drupal::configFactory()->getEditable('core.extension');
$mods = $ext->get('module') ?: [];
if (isset($mods[$module])) {
  unset($mods[$module]);
  $ext->set('module', $mods)->save(TRUE);
  echo "removed $module from core.extension\n";
} else {
  echo "$module already absent from core.extension\n";
}
$schema = \Drupal::keyValue('system.schema');
if ($schema->has($module)) { $schema->delete($module); echo "deleted system.schema: $module\n"; }
// drop any installed entity/field defs provided by plugin (defensive; usually none)
$kv = \Drupal::keyValue('entity.definitions.installed');
foreach ($kv->getAll() as $k => $v) {
  if (str_contains($k, 'plugin.entity_type')) { $kv->delete($k); echo "deleted installed def: $k\n"; }
}
echo "done\n";
