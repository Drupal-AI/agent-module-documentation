<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# babel_content_entity — the content_entity translation-type plugin

## Configuration & derivation
- Settings form `Form\BabelContentEntitySettingsForm` (`ConfigFormBase`, config `babel_content_entity.settings`,
  route `babel_content_entity.settings`, permission `language manager`). A multi-select of content entity
  types (`getContentEntityOptions()`), stored to `entity_type` via a `ConfigTarget` (`normalize`).
- `Plugin\Babel\BabelContentEntityDeriver` reads `entity_type` and emits one derivative per selected type:
  plugin id `content_entity:<entity_type>`, label = the entity type label.
- The plugin implements `PluginFormInterface`; its subform (on the main Babel settings page) limits the
  derivative to chosen `bundle`s (schema `translation_type.content_entity:*` → `bundle` sequence). When an
  entity type has a single bundle it is auto-selected.

## String harvesting (`BabelContentEntityService`)
Collects translatable string/text fields of each entity instance into Babel `Source` objects. `EXCLUDED_FIELDS`
skips `created`, `changed`, all `content_translation_*` keys, `default_langcode`, `langcode`,
`revision_translation_affected`. Field types considered are string/text field items. The service warns (in the
settings form) that selecting entity types with many entities is expensive — restrict to small, controlled sets.

## Save path (`ContentEntity::updateTranslation`)
1. Calls `parent::updateTranslation()` to update the Babel index/instance rows.
2. If `content_translation.manager` is unavailable, stops (index-only).
3. Loads the entity, verifies content translation is enabled for its `(entity_type, bundle)`.
4. Gets/creates the entity's translation in the target language, writes the field value, sets translation
   metadata author to the **current user** (`AccountProxyInterface`), and saves the entity translation
   (`$entityTranslation->save()` / `$entity->save()`).

## Operational note
Content-entity translations are editable by any user with Babel's `translate interface` permission once an
admin has opted the entity type in — Babel treats them as UI strings rather than routing through each
entity's own translate/edit form. Only expose entity types you are comfortable exposing to that role.

Source of truth remains the entity: nothing content-related is stored in Babel beyond the index/status/lock
rows. `EventSubscriber\BabelContentEntityConfigSubscriber` keeps derivatives/index in sync with config changes.
