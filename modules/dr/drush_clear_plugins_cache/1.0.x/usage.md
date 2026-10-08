<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Provides a Drush command to clear cached plugin definitions for a chosen plugin manager (or all of them).
- Lets plugin developers refresh discovery without running a full `drush cr`.
- A developer convenience module (depends on Devel).

---

## Install & configure

- Enable the module (requires `devel`).
- Use the Drush command provided by `PluginManagerCacheCommands` from the CLI.
- No web routes, permissions, or config are added.

---

## Usage & behaviour

- Implements a Drush command class (`src/Commands/PluginManagerCacheCommands.php`) registered via `drush.services.yml`.
- Clears the cached definitions of plugin managers so newly added/edited plugins are rediscovered.
- Faster and more targeted than a full cache rebuild during plugin development.
- Depends on Devel, signalling it is a development-only tool.
- No web-facing surface at all — CLI only, so no anonymous access concern.
- Use after adding a plugin annotation/class when the definition is not yet picked up.
- Complements `drush cr` when you want to avoid clearing render/page caches.
- Safe on any environment but intended for local/dev where Devel is present.
- Provides no data storage, cron, or queue work.
- Package is `Development`, matching its intended audience.
- Disable it (and Devel) on production as a hygiene measure.
- Works across Drupal 8.7.7+, 9 and 10.
- No configuration is exported; behaviour is entirely in the command.
- Pair with a plugin-heavy module (fields, blocks, migrate) where discovery caching slows iteration.
- The command targets plugin-manager caches specifically, not the full cache bins.
- Review `drush.services.yml` to see the exact command name and aliases for your version.
