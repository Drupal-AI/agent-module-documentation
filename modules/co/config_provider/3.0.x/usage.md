<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Provider is a developer framework that generalises how extensions provide configuration: it defines a `ConfigProvider` plugin type and a collector service so modules (e.g. Features, config packaging tools) can discover all the config an extension would install or update, beyond core's fixed `config/install` + `config/optional` behaviour.

---

The module defines a `ConfigProvider` annotation-based plugin type (`Plugin/ConfigProvider`) managed by `plugin.manager.config_provider.processor`, and ships two default plugins mirroring core's install storages: `config/install` (`ConfigProviderInstall`, weight -10) and `config/optional` (`ConfigProviderOptional`, weight 10). Each provider's `addInstallableConfig()` reads config from an extension directory (honouring install-profile overrides, config collections, and — for optional config — configuration-entity and dependency filtering) and writes the result into a shared in-memory provider storage (`config_provider.storage`, a core `MemoryStorage`). The `config_provider.collector` service (`ConfigCollector`) wires up every provider plugin, clears the provider storage, and runs them in weight order via `addInstallableConfig($extensions)`, so a caller can ask "what configuration is installable for these extensions?" and read it back from the provider storage. The module also decorates core's `config.installer` service with `ConfigProviderConfigInstaller` so provider plugins participate at extension-install time, and sets a high module weight (100) so its service alterations run last. It adds no admin UI (`configure: null`), no permissions, no Drush commands, and no config entity of its own — it is infrastructure other modules build on.

---

- Discover the full set of configuration an installed module or theme would provide, not just what core installs.
- Let a packaging/export tool (e.g. Features) enumerate installable config for a chosen list of extensions.
- Add a custom `ConfigProvider` plugin that provides config from a non-standard directory (beyond `config/install`).
- Collect config across all enabled extensions into one in-memory storage for analysis or diffing.
- Determine which optional config from `config/optional` currently meets its dependencies and could be installed.
- Honour install-profile config overrides when computing what an extension provides.
- Support alternative config collections (e.g. language overrides) when gathering installable config.
- Build a "config update" feature that compares provided config against active config to find drift.
- Reuse core's dependency-sorting and validation logic when deciding install order for optional config.
- Provide partial config (e.g. permissions merged into a role) via a provider that reports `providesFullConfig() === FALSE`.
- Weight providers so later ones can alter config added by earlier ones.
- Extend the config install pipeline via the decorated `config.installer` service without patching core.
- Add default `_core.default_config_hash` values to provided config for correct translation handling.
- Programmatically call `config_provider.collector` from an update hook or Drush script to stage config.
- Integrate distribution tooling that needs to know an extension's shipped configuration set.
- Filter collected config to a single extension by passing an Extension array to `addInstallableConfig()`.
- Underpin modules like Configuration Synchronizer / Config Distro that operate on extension-provided config.
- Read provided config back from `config_provider.storage` after collection for custom processing.
- Avoid re-implementing core's `ExtensionInstallStorage` and profile-override handling in your own module.
- Provide a stable extension point for "where does config come from" so multiple tools agree on the answer.
