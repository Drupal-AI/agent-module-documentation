# Define a cron job

Jobs are `ultimate_cron_job` config entities (`ultimate_cron.job.*`). Existing
`hook_cron()` implementations and queue workers are **auto-discovered** (on module install
and cache rebuild, via `ultimate_cron.discovery`), so you usually only add config to
override defaults or register extra jobs. Ship it as default config in your module's
`config/install/` (or `config/optional/`).

Example `config/install/ultimate_cron.job.my_module_ping.yml`:

```yaml
langcode: en
status: true
dependencies:
  module:
    - user
id: my_module_ping
title: 'Pings users'
module: my_module
callback: _my_module_user_ping_cron
scheduler:
  id: simple          # or 'crontab'
  configuration:
    rules:
      - '*/5+@ * * * *'
launcher:
  id: serial
  configuration:
    timeouts: { lock_timeout: 3600, max_execution_time: 3600 }
    launcher: { max_threads: 1 }
logger:
  id: database        # or 'cache'
  configuration: { method: '3', expire: 1209600, retain: 1000 }
```

Fields: `id` (machine name), `title`, `module`, `callback`, and one block each for the
`scheduler`, `launcher` and `logger` plugin (`id` + `configuration`). Weight controls order.

**Callback formats** (all accepted by `callback`):
- a function name — `_my_module_user_ping_cron`
- a module hook — `system#cron` (invoked via the module handler; supports `#[Hook]` in D11.1+)
- a static method — `Class::method`
- a service method — `service.name:method`
- an invokable class — a class name with an `__invoke()` method

Scheduling rule syntax is crontab-like with Ultimate Cron extensions: `+` adds a
catch-up/fuzz offset and `@` jitters the minute to spread load (e.g. `*/15+@ * * * *` ≈ every
15 min, staggered). The Simple scheduler exposes these as named interval presets; Crontab
accepts arbitrary rules. See [plugins/plugins.md](../plugins/plugins.md).
