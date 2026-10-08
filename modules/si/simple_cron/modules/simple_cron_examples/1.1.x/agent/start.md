<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# simple_cron_examples — agent index

Submodule of **simple_cron**. Ships three worked example `@SimpleCron` plugins so developers
can copy a minimal, a configurable, and a multi-type cron job. Enabling it registers the three
plugins; each becomes a manageable cron job in the parent's UI. Core `^10 || ^11`.

- Depends on: `simple_cron:simple_cron`.
- No settings page of its own (`configure` = null); jobs are managed via the parent at route
  `entity.simple_cron.collection`. No permissions, drush commands, services, or config schema
  of its own.
- Provides three plugin instances of the parent's `SimpleCron` plugin type (it does NOT define
  a new plugin type).

Solutions:
- **See how to implement a SimpleCron plugin (minimal / configurable / multi-type)** → [plugins/examples.md](plugins/examples.md)

Key facts:
- Plugin ids: `example_simple_cron_single`, `example_simple_cron_configurable`, `example_simple_cron_multi_types`.
- Classes (under `src/Plugin/SimpleCron/`): `SingleCron`, `ConfigurableCron`, `MultiTypesCron`.
- Base class extended: `Drupal\simple_cron\Plugin\SimpleCronPluginBase`; annotation `@SimpleCron` (`Drupal\simple_cron\Annotation\SimpleCron`).
- Discovered by parent manager service `plugin.manager.simple_cron` (discovery dir `Plugin/SimpleCron`, alter hook `simple_cron_info`).
- Log channel used by the examples: `simple_cron_examples`.
