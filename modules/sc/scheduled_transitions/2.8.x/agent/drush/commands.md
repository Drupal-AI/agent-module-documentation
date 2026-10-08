<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered via `drush.services.yml` → `ScheduledTransitionsCommands`.

## `scheduled-transitions:queue-jobs` (alias `sctr-jobs`)

Fills the `scheduled_transition_job` queue with **crawler jobs** for all currently due,
unprocessed, unlocked scheduled transitions (calls `ScheduledTransitionsJobs::jobCreator()`).
It does *not* execute them — run the queue afterwards:

```bash
drush scheduled-transitions:queue-jobs   # or: drush sctr-jobs
drush queue:run scheduled_transition_job
```

This is the same work cron performs when `automation.cron_create_queue_items` is `true`; use it
to process due transitions on demand (e.g. in tests or a manual run) without waiting for cron.
