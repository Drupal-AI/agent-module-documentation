<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Scheduler for ECK plugs in

## The Scheduler plugin
`Drupal\scheduler_eck\Plugin\Scheduler\EckScheduler` is annotated:

```
@SchedulerPlugin(
  id = "scheduler_eck",
  dependency = "eck",
  deriver = "Drupal\scheduler_eck\Plugin\Derivative\SchedulerEckDeriver",
)
```

It extends `Drupal\scheduler\SchedulerPluginBase` and overrides
`schedulerEventClass()` to return `SchedulerEckEvents::class`. The deriver
generates one plugin instance per ECK entity type so Scheduler treats each ECK
type like it treats nodes/media.

## Enabling scheduling
1. Install `scheduler` (>= 2.0.0-rc4) and `eck`.
2. Enable `scheduler_eck`.
3. In each ECK entity type/bundle's settings, enable Scheduler's
   publish-on / unpublish-on options.
4. Ensure cron runs — Scheduler processes due dates on cron.

There is no module-specific configuration; all scheduling UX comes from
Scheduler itself.
