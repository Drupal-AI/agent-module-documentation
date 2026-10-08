<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Augmenter API — agent index

A **plugin API only** — no settings form, no configure route, no permissions, no Drush. It
defines the `DateAugmenter` plugin type that date formatters (notably contrib **Smart Date**) use
to let site builders enable/order small "augmenter" plugins that modify date render output.
Config is stored as **formatter third-party settings** under `date_augmenter`.

- **Write an augmenter plugin (attribute/annotation, interface, base classes, configurable form)** →
  [plugins/create-augmenter.md](plugins/create-augmenter.md)
- **The plugin manager service, active-plugin selection, config structure & making a formatter opt in** →
  [api/manager.md](api/manager.md)

Key facts:
- Plugin type: manager service `plugin.manager.dateaugmenter`, directory `Plugin/DateAugmenter`,
  attribute `Drupal\date_augmenter\Attribute\DateAugmenter`, interface `DateAugmenterInterface`
  (`augmentOutput(array &$output, DrupalDateTime $start, ?DrupalDateTime $end, array $options)`).
- A formatter opts in via a `supportsDateAugmenter()` method; config is saved as
  `third_party_settings.date_augmenter` on the formatter component (schema
  `field.formatter.third_party.date_augmenter`, with `instances` / `rule` sets).
- Alter hook: `hook_date_augmenter_plugin_info`. Augmenter plugins ship in separate contrib modules.
