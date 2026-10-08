<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recurring Time Period (recurring_period) — agent index

Developer/API module. Defines a **RecurringPeriod plugin type**: configurable plugins that turn a
start date into a recurring time period (fixed calendar-aligned, rolling interval, or unlimited) and
iterate the sequence forward. Ships a `Period` value object and an entity trait for storing periods.
Built for Commerce License / Commerce Recurring but usable without Commerce.

- Version **8.x-1.3**. Core `^8.8 || ^9 || ^10 || ^11`.
- Requires **interval** (`interval:interval`, project drupal/interval) — periods are expressed with its interval element/plugins.
- No settings page, no permissions, no drush, no config schema. It provides no UI of its own — consuming modules embed the plugin's configuration form.

## What you'd do

- **Understand the plugin type and add a new period plugin** → [plugins/recurring_period.md](plugins/recurring_period.md)
- **Instantiate a plugin and calculate period start/end dates (the Period object)** → [api/usage.md](api/usage.md)
- **Store a calculated period on an entity (Period::toEntity, PeriodEntityTrait)** → [api/entity-integration.md](api/entity-integration.md)
- **Make the plugin type selectable by a Commerce plugin-reference field** → [events/commerce.md](events/commerce.md)

## Key facts

- Plugin type id: `recurring_period` (namespace `Plugin/RecurringPeriod`).
- Manager service: `plugin.manager.recurring_period` → `Drupal\recurring_period\RecurringPeriodManager`.
- Annotation: `@RecurringPeriod` (`Drupal\recurring_period\Annotation\RecurringPeriod`; keys `id`, `label`, `description`).
- Plugin interface: `Drupal\recurring_period\Plugin\RecurringPeriod\RecurringPeriodInterface`; base class `RecurringPeriodBase`.
- Bundled plugins: `fixed_reference_date_interval`, `rolling_interval`, `unlimited`.
- Value object: `Drupal\recurring_period\Datetime\Period`.
- Entity helpers: `Drupal\recurring_period\Entity\PeriodEntityTrait`, `PeriodEntityInterface`.
- Alter hook: `hook_recurring_period_info_alter` (alter id `recurring_period_info`).
- Event subscriber service: `recurring_period.referenceable_plugin_types_subscriber`.
- Plugin (drupal/plugin) integration: `recurring_period.plugin_type.yml` (decorator `ArrayPluginDefinitionDecorator`).
