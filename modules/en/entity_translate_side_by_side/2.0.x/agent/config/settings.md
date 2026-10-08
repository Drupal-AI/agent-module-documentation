<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object and skip-list hook

Files: `src/Form/LanguageConfigForm.php`, `config/schema/entity_translate_side_by_side.schema.yml`,
`entity_translate_side_by_side.routing.yml`, `entity_translate_side_by_side.links.menu.yml`,
`entity_translate_side_by_side.permissions.yml`, `entity_translate_side_by_side.api.php`.

## Install / enable

`drush en entity_translate_side_by_side -y`. Requires core `content_translation` (declared in
`info.yml` dependencies). No `config/install/` defaults ship — the settings config object is created
on first save of the settings form.

## Permission

`entity_translate_side_by_side.permissions.yml` defines a single permission
**`access entity translate side by side`** ("Access Entity Translate Side by Side"), required by the
translation route. The settings route requires core `administer site configuration`.

## Settings form

`LanguageConfigForm extends ConfigFormBase` (form id `entity_translate_side_by_side_admin_settings`),
route `entity_translate_side_by_side.admin_settings` at
`/admin/config/system/entity-translate-side-by-side` (menu link under
`system.admin_config_system`, weight 100).

- `buildForm()` lists all enabled site languages as a `languages` checkboxes element; default value =
  saved `languages`, or the site default language when none saved.
- `submitForm()` writes `array_filter($form_state->getValue('languages'))` to
  `entity_translate_side_by_side.settings:languages`.
- `getEditableConfigNames()` → `['entity_translate_side_by_side.settings']`.
- Injects `language_manager` in `create()`.

These configured languages become the default columns of the translation form when the visit has no
`langcodes` query param and the entity has no existing translations to fall back to.

## Config object + schema

`config/schema/entity_translate_side_by_side.schema.yml`:
```
entity_translate_side_by_side.settings:
  type: config_object
  mapping:
    languages:
      type: sequence
      sequence:
        type: string   # a language code
```
So the only stored setting is `languages` — a list of langcode strings.

## Skip-list alter hook

`entity_translate_side_by_side.api.php` documents
`hook_entity_translate_side_by_side_skip_alter(array &$skip)`. Modules append entity-type ids to
`$skip` to suppress the "Translate side by side" entity operation for those types (the module itself
seeds `menu_link_content`). Invoked in
`Hook\EntityTranslateSideBySideHooks::addTranslateSideBySideOperation()` via
`moduleHandler->alter('entity_translate_side_by_side_skip', $skip)`.
