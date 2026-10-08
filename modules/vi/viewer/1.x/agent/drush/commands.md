<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered via `drush.services.yml` (service `viewer.commands`, tag `drush.command`), class
`src/Commands/ViewerCommands.php` (extends `DrushCommands`, constructed with the `viewer.cron`
service).

## `viewer:import` (alias `vimp`)

Runs Viewer's automated imports immediately from the CLI, independent of the site cron schedule.
Internally calls `Cron::processQueue()` (`Services/Cron.php`) — the same routine `hook_cron` invokes
— which enqueues any source whose `next_import` is due into the `ViewerSourcesQueueProcessor` queue
worker and processes it (re-downloads the source file, re-parses, updates `last_import` /
`next_import`, and fires success/failure notification events).

```
drush viewer:import
drush vimp
```

No arguments or options. Use it to force a refresh of scheduled sources (e.g. after changing a
remote file) without waiting for the next cron run. Manual, one-off imports of a single source are
done through the UI import form (`entity.viewer_source.import`), not this command.
