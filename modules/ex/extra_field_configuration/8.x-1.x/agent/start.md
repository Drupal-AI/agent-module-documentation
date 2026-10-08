<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Field Configuration (extra_field_configuration) — agent index

Configuration layer over the **Extra Field** contrib module. Lets site builders bind an
`@ExtraFieldDisplay` plugin to entity type/bundle **view displays** via config entities at
`/admin/structure/extra-field`, instead of hard-coding the placement in the plugin annotation's
`bundles`. One plugin can back many named instances (reuse the same extra field multiple times on an
entity without duplicate plugin classes). Version **8.x-1.2**. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Package: none.

## Dependencies

- Core `field`.
- Contrib `extra_field:extra_field` (composer `drupal/extra_field:^2.0 || ^3.0`). Extra Field Plus
  plugins also work.
- Optional submodule `extra_field_configuration_examples` (sample plugins) — documented at
  [../../modules/extra_field_configuration_examples/8.x-1.x/agent/start.md](../../modules/extra_field_configuration_examples/8.x-1.x/agent/start.md).

## What it provides

- **Config entity** `extra_field_configuration` (class `Entity\ExtraFieldConfiguration`,
  `config_prefix = "display"`, `admin_permission = "administer extra fields"`; exported keys
  `id`, `label`, `plugin_id`, `bundles`).
- **Permission** `administer extra fields` (`*.permissions.yml`); gates all CRUD.
- **Routes** (`*.routing.yml`, all `_permission: 'administer extra fields'`):
  `entity.extra_field_configuration.collection` (`/admin/structure/extra-field`, list),
  `.add_form` (`/add`), `.edit_form` (`/edit/{extra_field_configuration}`),
  `.delete_form` (`/{extra_field_configuration}/delete`). Menu under *Structure*.
- **Service** `plugin.manager.extra_field_configuration_display` →
  `Plugin\ExtraFieldConfigurationDisplayManager` (subclass of extra_field's
  `ExtraFieldDisplayManager`).
- **Deriver** `Plugin\Derivative\ExtraFieldConfigurationDeriver` — turns each saved config entity
  into a derived `@ExtraFieldDisplay` plugin definition.
- **Hooks** (`.module`): `hook_entity_extra_field_info()` → manager `fieldInfo()`;
  `hook_entity_view()` → manager `entityView()`. Alter hook `extra_field_configuration_display_info`.
- **Config schema** `extra_field_configuration.display.*` (`config/schema/`).
- **Trait** `ExtraFieldConfigurationTrait` (shared cache-clearing + display cleanup helpers).

## Solution docs

- **The config entity, admin CRUD, config object/schema, how it renders** →
  [config/instances.md](config/instances.md)
- **The plugin type: making an extra field configurable (deriver, manager, field naming, templates)** →
  [plugins/configurable-extra-fields.md](plugins/configurable-extra-fields.md)

No settings form (`configure` is null); management is the collection UI. No Drush commands.
