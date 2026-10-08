<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# warmer_entity — agent start

Submodule of **warmer**. Provides one `@Warmer` plugin, id **`entity`** (`EntityWarmer`),
that warms the **entity cache** for the entity-type/bundle pairs you pick. Beyond the shared
`frequency`/`batchSize` it adds two settings: `entity_types` (list of `entity_type_id:bundle`
pairs) and `published_only`. No routes, permissions, services, or Drush of its own — it runs
through the parent Warmer framework and is configured in the Warmer settings form.

- What it configures (`warmer.settings:warmers.entity`, keys, how to warm it) → [configure/setup.md](configure/setup.md)
- Parent module (framework, plugin type, drush, cron) → [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md)
