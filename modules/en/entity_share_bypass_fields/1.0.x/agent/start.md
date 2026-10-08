<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Share Bypass Fields (entity_share_bypass_fields) — agent index

One Entity Share Client **import processor** that trims fields out of incoming synced entity data on the pulling site, so imports survive schema drift between sites. Package `Web services`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x. Installed release 1.0.2.

- **The processor — plugin definition, config setting, and how it trims the payload** →
  [plugins/bypass-fields-processor.md](plugins/bypass-fields-processor.md)

## What it actually is

- Depends on **`entity_share:entity_share_client`** (submodule of the Entity Share project). No other dependencies, no composer requirements.
- One plugin: `BypassFieldsProcessor` (`@ImportProcessor` id **`entity_share_bypass_fields`**, label *"Bypass fields"*) in `src/Plugin/EntityShareClient/Processor/BypassFieldsProcessor.php`, extending `ImportProcessorPluginBase` and implementing `PluginFormInterface`.
- Ships **no** routes, permissions, services, hooks, `.install`, or `config/` (no own config schema). It is configured only as a processor inside an Entity Share import config at `/admin/config/services/entity_share/import_config`.
- Runs at import stage **`prepare_entity_data`** (weight **-100**), `locked = false`.

## Mechanism (from source)

- One config key: `manual_bypassed_fields` (default `''`), rendered as a textarea in `buildConfigurationForm()`; operator enters comma-separated field machine names.
- `prepareEntityData(RuntimeImportContext, array &$entity_json_data)` splits `manual_bypassed_fields` on `,`, reads the entity type from `$entity_json_data['type']` (`entity_type--bundle`) and the UUID from `['id']`, and `loadByProperties(['uuid' => …])`.
- For each attribute in `$entity_json_data['attributes']`: `unset()` it if its name is in the manual list, else `unset()` it if it starts with `field_` and the loaded entity has no such field (`hasField()`).
- Duplicate/missing/non-fieldable entity and any exception are logged to the `entity_share_client` logger channel; the method returns without aborting the import.

## Clarification (name)

"Bypass fields" is a client-side **data-trimming** step: it only *removes* attributes from the JSON the client already fetched, before Entity Share writes them. It defines no new plugin type and does not change what the remote channel serves. Enabling it is governed by Entity Share Client's own import-config admin access.
