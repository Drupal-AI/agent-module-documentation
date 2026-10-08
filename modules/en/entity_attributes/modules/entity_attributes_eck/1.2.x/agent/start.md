<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Attributes ECK (entity_attributes_eck) — agent index

Submodule of **entity_attributes** that adds ECK (Entity Construction Kit) support. Package
**Fields**. Core `^11`. Depends on `entity_attributes:entity_attributes` and `eck:eck`. No config,
no permissions, no schema of its own — it reuses the parent module's settings form, per-bundle
permissions and `entity_attributes.processor` service.

## What it provides

- **Plugin** `EckEntityAttributes` (id `eck_entity`,
  `src/Plugin/EntityAttributes/EckEntityAttributes.php`) extending `ContentEntityAttributesBase`,
  `config_tab: eck_entity`, `config_section: bundles`. Its `getEntityTypes()` returns all
  `eck_entity_type` ids dynamically (so the plugin has no static `entity_types` list). Attribute set
  is the base default `['attributes']`; storage is the standard `entity_attributes` `string_long`
  field.
- **Preprocess hook** `entity_attributes_eck\Hook\PreprocessHooks::preprocessEckEntity()`
  (`#[Hook('preprocess_eck_entity')]`) → resolves the entity type from the entity and calls
  `processor->processContentEntityAttributes($eck_entity, $variables, $entity_type)`.

## Operate it

Enable the submodule, tick the ECK bundles at `/admin/config/search/entity-attributes`, grant
`edit entity attributes {eck_type} {bundle}`, then print `{{ attributes }}` in the ECK template.
See the parent module docs `modules/en/entity_attributes/1.2.x/agent/` for the full mechanism.
