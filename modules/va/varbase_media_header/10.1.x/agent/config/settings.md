<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & per-bundle activation

`src/Form/VarbaseMediaHeaderSettingsForm.php` (`VarbaseMediaHeaderSettingsForm extends ConfigFormBase`).

## Install / enable

- `composer require drupal/varbase_media_header` then `drush en varbase_media_header`.
- `varbase_media_header_install()` (`.install`) runs the recipe at `recipes/default`
  (`Recipe::createFromDirectory` + `RecipeRunner::processRecipe`), which grants
  `administer varbase media header` to the `site_admin` role. No other install action.
- Requires `varbase_media` and `varbase_components` (hard deps in `.info.yml` / `composer.json`).

## Route & permission

- Route `varbase_media_header.settings` → `/admin/config/varbase/varbase-media-header`,
  `_permission: 'administer varbase media header'` (the module's only permission).
- Menu link `varbase_media_header.settings` parents under `varbase_core.settings_index`
  (`.links.menu.yml`); a local task also points there (`.links.task.yml`).
- `configure` in `.info.yml` = `varbase_media_header.settings`.

## Config object `varbase_media_header.settings`

Schema `config/schema/varbase_media_header.schema.yml` (`config_object`):

- `varbase_media_header_settings` — sequence: `entity_type` → sequence of `bundle` → truthy string.
  Only `node` and `taxonomy_term` are offered (`$allowed_entity_types` in `buildForm()`).
- `hide_breadcrumbs` — boolean. When TRUE the breadcrumb block is suppressed inside the header
  (you can still place breadcrumbs via normal Block layout).

`getEditableConfigNames()` returns `['varbase_media_header.settings']`.

## buildForm()

- Iterates `entityTypeManager->getDefinitions()`, keeps `node` + `taxonomy_term`, and renders a
  `checkboxes` element per entity type whose options are the bundle labels
  (`bundleInfo->getBundleInfo()`). Default value = the bundles already truthy in
  `varbase_media_header_settings[$entity_type]`.
- A `hide_breadcrumbs` checkbox with a link to `block.admin_display` (Block layout).

## submitForm() → applyDefaultVarbaseMediaHeaderSettingsForActivatedEntityTypes()

Saves `varbase_media_header_settings` + `hide_breadcrumbs`, then for **each enabled bundle**:

1. `importManagedEntityConfigs($entity_type_key)` — if a `field.storage.{type}.field_media` /
   `field.storage.{type}.field_page_header_style` config exists, imports the storage from
   `config/managed/{type}/…` via `Vardot\Installer\ModuleInstallerFactory::importConfigsFromList`,
   then runs `Vardot\Entity\EntityDefinitionUpdateManager::applyUpdates()`.
2. Reads the bundled field templates in `src/assets/config_templates/{type}/`, `str_replace`s the
   `TOKEN_{TYPE}` placeholder with the real bundle machine name, `Yaml::decode`s, and writes:
   - `field.field.{type}.{bundle}.field_page_header_style` (a `list_string`: `standard` /
     `media_header`, required, default `standard`).
   - `field.field.{type}.{bundle}.field_media` (entity_reference → media).
   - merges the template's `content` into `core.entity_form_display.{type}.{bundle}.default`.
   - merges the template's `hidden` into `core.entity_view_display.{type}.{bundle}.default`.
   Each is written with `configFactory->getEditable(...)->setData(...)->save(TRUE)` (only when the
   target config already exists).
3. Finally `EntityDefinitionUpdateManager::applyUpdates()` + `drupal_flush_all_caches()`.

Net effect: enabling a bundle attaches the two Media-Header fields and wires their form/view display.
This is admin-only (permission-gated), config-writing, and idempotent.

## Media view mode

`config/optional/core.entity_view_mode.media.varbase_media_header.yml` declares the
`media.varbase_media_header` view mode; `config/optional/core.entity_view_display.media.{image,video,remote_video}.varbase_media_header.yml`
provide default displays. The block renders the referenced media through this view mode
(the exact mode is chosen on the block form — see [../plugins/block.md](../plugins/block.md)).
