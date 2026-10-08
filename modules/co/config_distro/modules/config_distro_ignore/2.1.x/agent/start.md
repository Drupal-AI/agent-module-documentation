<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Distro Ignore — agent index

Submodule of **config_distro**. Protects listed configuration from distribution updates: ignored
items keep their **active** (site) value on import. A Config Filter plugin + a settings config +
a form. Requires `config_distro` + `config_distro_filter` (the bridge that runs the filter).

- **The ignore lists (`config_distro_ignore.settings`), the filter plugin, wildcards/hash
  pinning, and the UI** → [configure/ignore.md](configure/ignore.md)

Parent: [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md).

Key facts:
- Config object `config_distro_ignore.settings` with sequences `all_collections`,
  `default_collection`, `custom_collections`. `configure` route
  `config_distro_ignore.settings` at `/admin/config/development/configuration/distro/ignore`.
- Filter plugin `DistroIgnoreFilter` (`@ConfigFilter` id `config_distro_ignore`,
  `storages = {config_distro.storage.distro}`, weight 10000): ignored config is read from active
  storage. Entries support `*`/`?` wildcards and an optional `::<md5-hash>` suffix.
