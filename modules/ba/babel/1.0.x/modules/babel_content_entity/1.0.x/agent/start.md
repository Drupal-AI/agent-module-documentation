<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel Content Entities (babel_content_entity) — agent index

Babel submodule. Depends on **babel**. Core `^10.4 || ^11.1 || ^12`.

Exposes admin-selected simple content entity types (taxonomy terms, shortcuts, etc.) as translatable UI
strings in Babel. Translations are stored as native `content_translation` entity translations.

## Provides
- **Translation-type plugin `content_entity`** (derived) — `Plugin\Babel\TranslationType\ContentEntity`
  with deriver `Plugin\Babel\BabelContentEntityDeriver` → one derivative `content_entity:<entity_type>`
  per configured entity type. Implements `PluginFormInterface` (per-type bundle limiting).
- **Route** `babel_content_entity.settings` — `/admin/config/regional/babel/settings/content-entity`,
  form `Form\BabelContentEntitySettingsForm`, permission `language manager` (see note below).
- **Config** `babel_content_entity.settings` — `entity_type` (sequence of content entity type IDs,
  constrained `PluginExists` on `ContentEntityInterface`); schema also defines
  `translation_type.content_entity:*` with a `bundle` sequence. Local task tab under Babel settings.
- **Services** `BabelContentEntityService` (harvests fields, `EXCLUDED_FIELDS` skips langcode/metadata),
  `EventSubscriber\BabelContentEntityConfigSubscriber`, `BatchHelper`.

## Permission note
`babel_content_entity.settings` requires `language manager`, which is not declared by core or Babel — in
practice only UID 1 can open the settings form (same alpha oversight as the parent settings route).

## Solution docs
- `agent/plugins/content-entity.md` — the derived plugin, field harvesting, save path, settings.
