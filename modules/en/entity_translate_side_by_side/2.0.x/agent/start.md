<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Translate Side by Side (entity_translate_side_by_side) — agent index

A form that renders a translatable content entity's fields once per language, side by side, so an
editor translates all languages on one screen. Package **Entity**. Depends on core
**`content_translation`**. Core `^10 || ^11`, PHP `>=8.3`. License GPL-2.0-or-later. Version
**2.0.x** (installed as a dev checkout — `info.yml` carries no `version` line).

- **The translation form, its route, controller title, breadcrumb, entity operation and JS** →
  [forms/translate-form.md](forms/translate-form.md)
- **Default-language settings form, config object, schema and the skip-list alter hook** →
  [config/settings.md](config/settings.md)

## What it actually is

- One route `entity_translate_side_by_side` at `/entity-translate/{entity_type}/{entity_id}`
  (`entity_translate_side_by_side.routing.yml`) served by the form
  `Form\EntityTranslateSideBySideForm` with title callback
  `Controller\EntityTranslateSideBySideController::titleCallback()`. Permission requirement:
  `access entity translate side by side`.
- One settings route `entity_translate_side_by_side.admin_settings` at
  `/admin/config/system/entity-translate-side-by-side` → `Form\LanguageConfigForm`
  (permission `administer site configuration`); linked from `*.links.menu.yml`.
- Config object `entity_translate_side_by_side.settings` (key `languages`, a sequence of langcodes;
  schema in `config/schema/`).
- One permission (`*.permissions.yml`): **`access entity translate side by side`**.
- `hook_entity_operation` (via `Hook\EntityTranslateSideBySideHooks`) adds a "Translate side by
  side" operation to translatable entities with numeric IDs; skips `menu_link_content`; the skip
  list is alterable via `hook_entity_translate_side_by_side_skip_alter()` (see
  `entity_translate_side_by_side.api.php`).
- Breadcrumb builder service `entity_translate_side_by_side.breadcrumb`
  (`Breadcrumb\EntityTranslateSideBySideBreadcrumbBuilder`, priority 100).
- Two libraries (`*.libraries.yml`): `edit_form_styles` (CSS) and `edit_form_scripts`
  (`js/edit_form_scripts.js`, `js/drag_and_drop_scrolling.js`; depends on core/jquery, core/drupal).
- No entities, no plugin types, no Drush commands, no services beyond the breadcrumb builder.
