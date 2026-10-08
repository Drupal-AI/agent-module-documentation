<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Static Cron — agent index

Builds the Tome Static site incrementally on cron via a queue worker, instead of `drush
tome:static`. Depends on `tome_static`. Its whole interface is one config value plus core cron;
it adds no Drush command.

- **The Base URL config, the settings route, and how the cron/queue flow works** →
  [configure/settings.md](configure/settings.md)

Key facts: set `tome_static_cron.settings:base_url` at
`/admin/config/services/tome_static_cron/settings` (permission `use tome static`). If it is
empty, `hook_cron()` does nothing. Paths are enqueued into the `tome_static_cron` queue and
rendered by `TomeStaticQueueWorker` on later cron runs.
