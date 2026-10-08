# Configure the purge pipeline

There is no `configure` route in `purge` core — configuration is done through the **Purge UI**
submodule (`/admin/config/development/performance/purge`) or via Drush. Enabled plugins are
stored in the `purge.plugins` config object.

## purge.plugins (config)
```yaml
purgers:                 # ordered list of enabled purger instances (id => plugin_id)
  a1b2c3: cache_tags     # example; real ids come from an installed purger module
processors:              # enabled processor plugins
  purge_processor_cron.processor: purge_processor_cron.processor
queuers:                 # enabled queuer plugins
  purge_queuer_coretags.queuer: purge_queuer_coretags.queuer
queue: database          # active queue plugin (only one)
```
`purge.logger_channels` config records per-service log verbosity.

## Pieces you configure
- **Purgers** — the plugins that talk to the external cache. Order matters; multiple allowed.
  Comes from a purger module (not shipped here).
- **Queue** — exactly one queue backend (default `database`; a memory queue exists for tests).
- **Queuers** — what feeds the queue (typically `purge_queuer_coretags`).
- **Processors** — what drains the queue (`purge_processor_cron` and/or `_lateruntime`).

## Capacity & diagnostics
- `purge.purgers.tracker.capacity` (CapacityTracker) limits invalidations processed per request
  based on purger-declared cost/limits — prevents overload.
- `purge.diagnostics` runs DiagnosticCheck plugins; results show on the status report and can
  block processing (e.g. "no purger installed", "capacity too low"). Check with
  `drush p:diagnostics`.
