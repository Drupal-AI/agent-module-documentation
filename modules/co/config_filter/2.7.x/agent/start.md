# config_filter — agent start

API-only module. Provides the `ConfigFilter` plugin type + a `FilteredStorage` decorator so
modules can transform config as it syncs to/from `config.storage.sync`. No UI, no permissions,
no config, no dependencies. Bridges Drupal 8.8+ core config storage transformation events.

- Implement a `ConfigFilter` plugin (filter config on read/write) → [plugins/config_filter.md](plugins/config_filter.md)
- Services & storage decorators to call in code → [api/config_filter.md](api/config_filter.md)
- Register an alternative filter manager (non-plugin providers) → [extend/config_filter.md](extend/config_filter.md)
- Alter discovered filter definitions → [hooks/config_filter.md](hooks/config_filter.md)
