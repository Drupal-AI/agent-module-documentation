<?php
// Rip out the half-installed commerce_giftcard WITHOUT running its normal uninstall hooks
// (which query the missing commerce_giftcard_transaction table and fatal). The module's
// hook_entity_base_field_info injects a `commerce_giftcards` base field into commerce_order
// whose storage was never installed, so every commerce_order table-mapping/views-data build
// fatals site-wide. Disabling the module in core.extension stops that hook from firing.

$module = 'commerce_giftcard';

// 1) remove from core.extension (disable) so its hooks stop running
$ext = \Drupal::configFactory()->getEditable('core.extension');
$mods = $ext->get('module') ?: [];
if (isset($mods[$module])) {
  unset($mods[$module]);
  $ext->set('module', $mods)->save(TRUE);
  echo "removed $module from core.extension\n";
} else {
  echo "$module already absent from core.extension\n";
}

// 2) drop its entity type definitions from installed defs (+ commerce_order field def if present)
$kv = \Drupal::keyValue('entity.definitions.installed');
foreach (['commerce_giftcard.entity_type', 'commerce_giftcard_transaction.entity_type',
          'commerce_giftcard.field_storage_definitions', 'commerce_giftcard_transaction.field_storage_definitions'] as $k) {
  if ($kv->has($k)) { $kv->delete($k); echo "deleted installed def: $k\n"; }
}
$co = $kv->get('commerce_order.field_storage_definitions');
if (is_array($co) && isset($co['commerce_giftcards'])) {
  unset($co['commerce_giftcards']);
  $kv->set('commerce_order.field_storage_definitions', $co);
  echo "removed commerce_giftcards from commerce_order field defs\n";
}

// 3) remove system.schema entries
$schema = \Drupal::keyValue('system.schema');
foreach ([$module] as $m) { if ($schema->has($m)) { $schema->delete($m); echo "deleted system.schema: $m\n"; } }

// 4) delete leftover giftcard config entities (giftcard types) so config import stays clean
$cf = \Drupal::configFactory();
foreach ($cf->listAll('commerce_giftcard.') as $name) {
  $cf->getEditable($name)->delete();
  echo "deleted config: $name\n";
}

echo "done (rebuild caches next)\n";
