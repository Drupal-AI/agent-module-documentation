<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object & field lifecycle

## Install / enable
`drush en entity_weight`. Only core Field/Field UI are needed (declared implicitly; no
`dependencies` in `entity_weight.info.yml`, empty `composer.json` require beyond core). `configure`
route is `entity_weight.settings`.

## Config object `entity_weight.settings`
Defined in `config/install/entity_weight.settings.yml`, typed in
`config/schema/entity_weight.schema.yml` (`type: config_object`):
- `enabled_bundles` — `sequence` of `sequence` of string. Keyed by entity type id, each value a list
  of enabled bundle machine names. Default `{}`.
- `min_weight` — integer, default `-100`.
- `max_weight` — integer, default `100`.
- `include_unpublished` — boolean, default `true`.

## Settings form — `EntityWeightSettingsForm` (`src/Form/EntityWeightSettingsForm.php`)
Extends `ConfigFormBase`; `getEditableConfigNames()` returns `entity_weight.settings`; route perm
`administer entity weight`.

`buildForm()` renders a *Weight Range* fieldset (`min_weight`, `max_weight` number inputs,
`include_unpublished` checkbox) and an *Enable weight...* fieldset. It iterates
`entity_weight_applicable_entity_types()` and for each renders a `details` element with a
`checkboxes` element `bundles_<entity_type_id>` of the bundle labels; the details opens when the type
already has enabled bundles.

`validateForm()` errors if `min_weight >= max_weight`.

`submitForm()`:
1. Collects the new `enabled_bundles` from each `bundles_<type>` value (`array_filter`).
2. Saves `min_weight`, `max_weight`, `include_unpublished`, `enabled_bundles`.
3. For each newly enabled bundle calls `entity_weight_create_field()`; for bundles already enabled
   calls `entity_weight_update_field()` (pushes new min/max onto the field instance).
4. For bundles removed from the list calls `entity_weight_delete_field()`.
5. Calls `plugin.manager.menu.link->rebuild()` so dynamic bundle links refresh.

## Eligible entity types — `entity_weight_applicable_entity_types()` (`entity_weight.module`)
Returns every entity type whose class implements `FieldableEntityInterface`, **excluding**
`user`, `file`, `path_alias`, `shortcut`, `content_moderation_state`. Both the settings form build and
submit use this same list.

## Field lifecycle helpers (`entity_weight.module`)
- `entity_weight_create_field($entity_type_id, $bundle)` — creates `FieldStorageConfig`
  `field_entity_weight` (type `integer`, cardinality 1, `translatable`, **`locked`**,
  `persist_with_no_fields`, module `entity_weight`) if absent, then a `FieldConfig` instance
  (default value 0, settings `min`/`max` from config), and sets the `entity_weight_selector` widget
  (weight 100, `hidden` TRUE) on the `<type>.<bundle>.default` `entity_form_display` (creating the
  display if needed).
- `entity_weight_update_field(...)` — updates the instance `min`/`max` settings.
- `entity_weight_delete_field(...)` — deletes the `FieldConfig` instance for a bundle.
- `entity_weight_is_enabled($entity_type_id, $bundle)` — checks membership in `enabled_bundles`.

## Uninstall (`entity_weight.install`)
`entity_weight_uninstall()` walks `enabled_bundles`, deletes each `field_entity_weight` `FieldConfig`
instance, then deletes the per-entity-type `FieldStorageConfig`. Clean removal, no orphaned config.

## Menu links (`entity_weight.links.menu.yml`)
Static links `entity_weight.settings` (under `system.admin_config`) and `entity_weight.list` (under
`system.admin_structure`). `entity_weight.dynamic_links` uses deriver
`Plugin\Derivative\EntityWeightMenuLink`, which reads `enabled_bundles` and emits one child link per
bundle (`title` = "<Type>: <Bundle>", route `entity_weight.order`, parent `entity_weight.list`).
Link class `Plugin\Menu\EntityWeightMenuLink` (thin `MenuLinkDefault` subclass).

## hook_help
`entity_weight_help()` renders `README.md` on `help.page.entity_weight` (via the `markdown` parser if
available, otherwise `<pre>`).
