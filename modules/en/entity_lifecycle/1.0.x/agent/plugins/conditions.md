<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `LifecycleCondition` plugin type

## Plugin type

- Manager: `LifecycleConditionManager` (service `plugin.manager.lifecycle_condition`,
  `src/LifecycleConditionManager.php`) — a `DefaultPluginManager`; discovery dir
  `Plugin/LifecycleCondition`, interface `LifecycleConditionInterface`, annotation
  `Annotation\LifecycleCondition`, alter hook `lifecycle_condition_info`, cache key
  `lifecycle_condition_plugins`. Helpers: `getApplicableConditions($entity_type_id)`,
  `getConditionOptions($entity_type_id = NULL)` (both filter by the annotation's `entity_types` and sort
  by `weight`).
- Annotation (`@LifecycleCondition`): `id`, `label`, `description`, `entity_types` (empty = all),
  `category` (`general`/`content`/`user`/`usage`), `weight`.
- Interface (`src/LifecycleConditionInterface.php`, `@api`): `label()`, `description()`,
  `evaluate(ContentEntityInterface): bool`, `getValue()`, `getFormattedValue()`,
  `buildConfigurationForm()`, `summary()`, `isApplicable($entity_type_id): bool`. Extends
  `ConfigurableInterface`, `PluginInspectionInterface`, `ContainerFactoryPluginInterface`.
- Base class (`src/LifecycleConditionBase.php`, `@api`) — wires the module handler, implements
  configuration handling and `isApplicable()` (respects the annotation's `entity_types` plus
  `hook_entity_lifecycle_condition_excluded_entity_types()`), defaults `getFormattedValue()` to
  `getValue()`. Subclass `create()` should call `parent::create()`.

## How conditions are stored & evaluated

Per bundle, config holds `conditions[]`; each condition assigns a `status`, has a `weight`, and holds
either `groups[]` (each group = a set of `plugins[]` ANDed together; groups combined by a `group_operator`
AND/OR) or a legacy flat `plugins[]`. The evaluator returns the first matching condition's status in
weight order (see services/scanning.md). A plugin config item is `{plugin_id, configuration}`.

## Built-in condition plugins (`src/Plugin/LifecycleCondition/`)

- **`age`** — `AgeCondition`, category `content`. Config `created_months`, `changed_months`. Matches when
  the entity is older than `created_months` since `created` AND unchanged for `changed_months` since
  `changed` (a threshold of 0 disables that half; both 0 → no match). Uses 30-day months and
  `datetime.time`.
- **`published_status`** — `PublishedStatusCondition`, category `content`. Config `published_status`
  (`published`|`unpublished`, default unpublished). Only applies to `EntityPublishedInterface` entities;
  `isApplicable()` excludes `user`.
- **`default_status`** — `DefaultStatusCondition`, category `general`, weight 100. Always TRUE — a
  catch-all; place last so it only applies to content matching nothing else.

## Submodule condition plugins

`entity_lifecycle_user`: `AccountAgeCondition`, `AccountStatusCondition`, `LastLoginCondition` (category
`user`). `entity_lifecycle_entity_usage`: `EntityUsageCondition` (category `usage`).
`entity_lifecycle_linkchecker`: `BrokenLinksCondition`. `entity_lifecycle_radioactivity`:
`RadioactivityCondition`. See [../submodules.md](../submodules.md).

## Writing a condition

Add a class under your module's `src/Plugin/LifecycleCondition/`, annotate `@LifecycleCondition`, extend
`LifecycleConditionBase`, implement `evaluate()` (and typically `getFormattedValue()`,
`buildConfigurationForm()`, `summary()`, `defaultConfiguration()`). Limit it to entity types with the
annotation `entity_types` list, or exclude types from other modules with
`hook_entity_lifecycle_condition_excluded_entity_types()`. To support a new bundleless entity type,
implement `hook_entity_lifecycle_bundleless_entity_types()` (see `entity_lifecycle.api.php`).
