<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activity-type plugin framework

Activity **behaviour** (currently: how an activity computes its label) is delegated to a plugin,
chosen per activity type via the type's `plugin_id` config key (default `generic`).

## Manager & discovery

- Service `plugin.manager.crm_core_activity.activity_type` = `ActivityTypePluginManager`
  (`src/ActivityTypePluginManager.php`), a `DefaultPluginManager`:
  - namespace `Plugin/crm_core_activity/ActivityType`
  - interface `ActivityTypePluginInterface`
  - annotation `Annotation\ActivityTypePlugin` (`id`, `label`, `description`)
  - alter hook `activity_type_plugin_info`, cache key `activity_type_plugins`.
- `crm_core_activity.plugin_type.yml` also registers `activity_type_plugin` with the contrib
  `plugin` module (decorator `ArrayPluginDefinitionDecorator`) for plugin-type UIs.

## Base class & interface

- `ActivityTypePluginBase` (`src/ActivityTypePluginBase.php`) — merges config over
  `defaultConfiguration()`; `label(ActivityInterface $entity)` returns the activity `title`;
  `display()` returns `[]`; `calculateDependencies()` returns `[]`.
- Implement `ActivityTypePluginInterface` (see `src/ActivityTypePluginInterface.php`).

## Shipped plugin

- `Generic` (`src/Plugin/crm_core_activity/ActivityType/Generic.php`), id `generic`, label
  "Generic activity type" — empty subclass of the base (title-as-label behaviour).

## How a type uses it

`ActivityType` (config entity) stores `plugin_id` + `plugin_configuration` and lazily instantiates
the plugin through a `DefaultSingleLazyPluginCollection` (`getPlugin()`,
`getPluginCollection()`). `Activity::label()` calls `$type->getPlugin()->label($activity)`.

## Writing your own

Create `src/Plugin/crm_core_activity/ActivityType/MyType.php` with an `@ActivityTypePlugin`
annotation and extend `ActivityTypePluginBase`, overriding `label()` / `display()` /
`defaultConfiguration()` as needed. Config for the plugin is validated against
`crm_core_activity.configuration.<plugin_id>` in the config schema (the shipped `generic` schema is
an empty sequence). A test example lives in
`tests/modules/crm_core_activity_plugin_test/…/ActivityTypeWithConfig.php`.
