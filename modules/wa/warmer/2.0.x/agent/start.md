<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# warmer — agent start

Framework for **cache warming / pre-fetching**. It ships no warmers of its own — it
provides a `warmer` **plugin type** plus the plumbing to enqueue and process items in
batches. A warmer plugin (`@Warmer` annotation, extends `WarmerPluginBase`) knows how to
build batches of item IDs, load them, and warm them. All warmers share one config object
**`warmer.settings`** (`warmers.<id>` → `frequency`, `batchSize`, plugin-specific keys),
a reliable **`warmer` queue**, and a `hook_cron` that re-enqueues warmers whose `frequency`
window has elapsed. Configure at `/admin/config/development/warmer/settings`; warm manually
at `/admin/config/development/warmer` or with Drush. No permissions of its own — both routes
require `administer site configuration`. Concrete warmers come from the two submodules.

- The `warmer` plugin type — annotation, manager, interface, how to write one → [plugins/warmer.md](plugins/warmer.md)
- Config object `warmer.settings`, keys, admin routes, cron behavior → [configure/warmer.md](configure/warmer.md)
- Drush: `warmer:enqueue`, `warmer:list`, the `warmer` queue → [drush/commands.md](drush/commands.md)
- Services & programmatic warming (`plugin.manager.warmer`, `warmer.queue_manager`) → [api/services.md](api/services.md)
- Submodule **warmer_entity** (Entity warmer) → [../../modules/warmer_entity/2.0.x/agent/start.md](../../modules/warmer_entity/2.0.x/agent/start.md)
- Submodule **warmer_cdn** (CDN + Sitemap warmers) → [../../modules/warmer_cdn/2.0.x/agent/start.md](../../modules/warmer_cdn/2.0.x/agent/start.md)
