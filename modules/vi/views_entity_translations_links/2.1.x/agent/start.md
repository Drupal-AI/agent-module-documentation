<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Entity Translations Links (views_entity_translations_links) — agent index

A single-purpose Views field plugin. It renders, per row entity, one link for each enabled
language: **Edit** when that translation exists, **Add** when it does not — styled as flag
buttons. Intended for editorial content listings on multilingual sites.

- **Version:** 2.1.0 · **Package:** Custom · **License:** GPL-2.0-or-later
- **Core:** `^8.8 || ^9 || ^10 || ^11` (verified on Drupal 11.4)
- **Dependency:** `config_rewrite` (`^1.1`) — used only to ship a rewrite of the core
  `views.view.content` config that pre-adds the field to the admin Content view.
- **No** config form, permissions, Drush commands, or config schema of its own.

## Mechanism (from source)

- `views_entity_translations_links.module` → `hook_views_data_alter()` registers one field,
  `translation_button` (Views field plugin id `entity_translations`), against **every entity
  type's base table**. So the field can be placed on any entity View.
- `src/Plugin/views/field/EntityTranslations.php` is the plugin:
  - `render(ResultRow)` loops enabled languages. `hasTranslation($langcode)` → `#type => link`
    titled `Edit {langcode} translation`, url = the translation's `edit-form`. Else if
    `isTranslatable()` → link `Add {langcode} translation`, url = `Url::fromRoute('entity.<type>.content_translation_add', {source: entity lang, target: langcode, <type>: id})`.
  - Attaches library `views_entity_translations_links/views.entity.translations.links` (flag CSS).
  - Option `destination` (default TRUE) adds a `destination` query param via `RedirectDestinationTrait`.
  - Uses `EntityTranslationRenderTrait`; `query()` delegates to the entity-translation renderer
    when the site is multilingual, and does **not** call `parent::query()`.
  - `clickSortable()` FALSE, `usesGroupBy()` FALSE. `label()` returns a placeholder that the
    table preprocess overwrites.
- `hook_preprocess_views_view_table()` replaces the field's column header with a row of
  per-language flag spans.
- `css/translation_links.css` + `images/*.png` map langcode / add / edit classes to country flags.

## What to read next

- `agent/views/field.md` — how to add and configure the field in a View, header behaviour,
  entity-type applicability, and the destination option.
- `usage.md` — prose overview and use-case list.
