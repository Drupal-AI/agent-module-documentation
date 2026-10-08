<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Example `@SimpleCron` plugins for the simple_cron module — a minimal job, a configurable job, and a multi-type job you can copy when writing your own.

---

The simple_cron_examples submodule is a developer reference for the parent simple_cron module. It contains three example plugin classes under `src/Plugin/SimpleCron/`, each extending `SimpleCronPluginBase` and annotated with `@SimpleCron`: `SingleCron` (`example_simple_cron_single`) shows the bare minimum — just a `process()` method that logs; `ConfigurableCron` (`example_simple_cron_configurable`) shows a per-job settings form built with `defaultConfiguration()` and `buildConfigurationForm()`, service injection via `create()`, and reading a saved value with `getConfigValue()`; `MultiTypesCron` (`example_simple_cron_multi_types`) shows how one plugin can back several parallel jobs via `getTypeDefinitions()` and branch on `getType()`, including throwing an exception to record a failed run. Enabling the submodule registers the three plugins so they appear as cron jobs in the parent's UI, where you can enable, schedule, and (for the configurable one) configure them. It adds no routes, permissions, services, config schema, or drush commands of its own. Turn it on while learning or scaffolding; keep it off in production.

---
- Learn the minimal shape of a SimpleCron plugin by reading `SingleCron`.
- Copy `SingleCron` as a starting template for a new cron job.
- See exactly which method (`process()`) you must implement.
- Study how a per-job configuration form is added (`ConfigurableCron`).
- Learn how to inject services into a SimpleCron plugin via `create()`.
- See how `defaultConfiguration()` supplies default settings values.
- Learn to read a stored setting inside `process()` with `getConfigValue()`.
- Understand how one plugin can run multiple parallel jobs (`MultiTypesCron`).
- See how `getTypeDefinitions()` declares job types.
- Learn how `getType()` lets `process()` branch per job type.
- Observe how a thrown exception marks a cron run as failed with a status message.
- See how to read the last successful run time via `getCronJob()->getLastRunTime()`.
- Verify your simple_cron install by enabling the examples and running cron.
- Watch example log messages appear on the `simple_cron_examples` channel.
- Demonstrate the parent's cron-job list/enable/disable UI with ready-made jobs.
- Test scheduling behaviour against a known, safe example job.
- Reference the correct `@SimpleCron` annotation format (id + label).
- Confirm the plugin discovery directory (`Plugin/SimpleCron`) with real classes.
- Teach a team how simple_cron plugins work using runnable examples.
- Reproduce a failing-job scenario for debugging status/error handling.
