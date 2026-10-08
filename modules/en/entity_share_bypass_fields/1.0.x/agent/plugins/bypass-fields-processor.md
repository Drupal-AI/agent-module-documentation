<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BypassFieldsProcessor — Entity Share Client import processor

File: `src/Plugin/EntityShareClient/Processor/BypassFieldsProcessor.php`
Class: `Drupal\entity_share_bypass_fields\Plugin\EntityShareClient\Processor\BypassFieldsProcessor`
Extends `ImportProcessorPluginBase` (from `entity_share_client`), implements `PluginFormInterface`.

## Plugin definition (`@ImportProcessor` annotation)

- `id = "entity_share_bypass_fields"`
- `label = "Bypass fields"`
- `stages = { "prepare_entity_data" = -100 }` — runs in the `prepare_entity_data` stage at weight -100 (early).
- `locked = false` — operators can enable/disable it per import config.

This is an instance of Entity Share Client's existing `ImportProcessor` plugin type; the module does **not** define a new plugin type.

## Install / enable

1. `drush en entity_share_bypass_fields` (pulls in `entity_share_client` if not already enabled).
2. Go to `/admin/config/services/entity_share/import_config`, edit an import config.
3. In the **Processors** section, enable **Bypass fields**.
4. Optional: open its settings and fill the **"Bypass fields manually"** textarea.

There is no module-level settings form and no `configure` route — all configuration lives inside the Entity Share import config entity.

## Configuration

`defaultConfiguration()` returns a single key:

- `manual_bypassed_fields` — string, default `''`.

`buildConfigurationForm()` renders it as a `#type => 'textarea'` titled *"Bypass fields manually"*, described as: fields comma-separated (e.g. `field_one,field_two,field_three`). The value is stored in the import config's processor settings (schema owned by `entity_share_client`, not this module).

## Runtime behavior — `prepareEntityData(RuntimeImportContext $runtime_import_context, array &$entity_json_data)`

Operates on the JSON:API payload (`$entity_json_data`) by reference, so unset attributes never reach the entity write:

1. `$manuallyExcludedFields = explode(',', $this->configuration['manual_bypassed_fields'])`.
2. Read entity type from `$entity_json_data['type']` (format `entity_type--bundle`, split on `--`) and UUID from `$entity_json_data['id']`.
3. `loadByProperties(['uuid' => $entityUuid])` via `entity_type.manager` storage for the entity type.
   - `count > 1` → log error, return.
   - empty result → log error, return.
   - not a `FieldableEntityInterface` → log error, return.
4. Loop `$entity_json_data['attributes']`:
   - if attribute name is in `$manuallyExcludedFields` → `unset()` it, `continue`.
   - else if name `str_starts_with('field_')` and `!$entity->hasField(name)` → `unset()` it.
5. Any exception is caught and logged `critical`.

All logging uses `$this->logger` = `logger.channel.entity_share_client`. `create()` injects `entity_type.manager` and that logger channel.

## Notes / gotchas

- Only attributes whose machine name literally begins with `field_` are auto-dropped when missing; base fields and non-`field_` attributes are only dropped if explicitly listed in `manual_bypassed_fields`.
- The manual list is matched by exact attribute name; no trimming of surrounding whitespace, so `field_one, field_two` would try to match a name ` field_two` (with a leading space). Enter names without spaces after commas.
- The processor requires the target entity to already exist locally (loaded by UUID) to detect missing `field_*` attributes; for a brand-new entity with no local match it logs and returns without trimming.
- Trimming happens after the client has fetched the remote payload; it changes only what gets written locally, not what the remote channel exposes.
