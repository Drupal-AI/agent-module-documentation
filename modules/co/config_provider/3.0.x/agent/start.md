<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Provider — agent index

Developer framework: a **`ConfigProvider` plugin type** + a **collector service** that answer
"what configuration does an extension provide (install/optional/…)?". No admin UI
(`configure: null`), no permissions, no Drush, no config entity. Requires core `config`.

- **Implement a ConfigProvider plugin (base class, annotation, methods, weights, the two
  built-in providers)** → [plugins/config-provider.md](plugins/config-provider.md)
- **Collect installable config programmatically (the collector service + provider storage,
  the `config.installer` decorator)** → [api/collector.md](api/collector.md)

Key facts:
- Plugin type dir `Plugin/ConfigProvider`, manager `plugin.manager.config_provider.processor`,
  annotation `@ConfigProvider`, base `ConfigProviderBase`.
- Two shipped plugins: `config/install` (weight -10) and `config/optional` (weight 10).
- `config_provider.collector` runs all providers; results land in `config_provider.storage`
  (a core `MemoryStorage`).
