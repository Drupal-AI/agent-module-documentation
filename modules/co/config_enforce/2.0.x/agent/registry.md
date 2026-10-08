<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_enforce — enforced-config registry

Enforcement is declared per **target module** in a config object named
`config_enforce.registry.<module>`, shipped as
`<module>/config/install/config_enforce.registry.<module>.yml`. The Config Enforce Devel UI writes
these for you, but the format is plain YAML you can author by hand. Schema:
`config/schema/config_enforce.schema.yml`.

```yaml
# my_module/config/install/config_enforce.registry.my_module.yml
enforced_configs:
  'system:site':                     # config object name, dots encoded as colons
    config_directory: config/optional # where the YAML lives inside the module: config/install or config/optional
    enforcement_level: 20             # 0 = off, 10 = no UI submit, 20 = read-only + re-import
    config_form_uri: /admin/config/system/site-information  # informational; shown in the indicator (nullable)
    hash: Zi0FaGPIOpgWctvx0HaKhLLS4KcQdkVb2DVkW8MM7PQ        # base64 hash of the on-disk YAML
```

Key points:
- **Name encoding** — map keys use `:` where the config name uses `.` (config keys forbid `.`; config
  names forbid `:`). `EnforcedConfigRegistry::encode()`/`decode()` do `str_replace('.', ':', …)` and
  back. So `system.site` is stored as `system:site`.
- **The config itself must also be shipped** at the derived path
  `<target_module_path>/<config_directory>/<config_name>.yml`
  (`EnforcedConfigRegistry::getDerivedConfigFilePath()`). `config_directory` is `config/install` or
  `config/optional`; `config/optional` is the only one re-imported when `--only-optional` is used.
- **`hash`** is a base64 hash (`Crypt::hashBase64`) of the on-disk file / active config used to detect
  drift. If it doesn't match the current file, level-20 enforcement re-imports on the next trigger. In
  the module's own test fixtures the registry object's own hash is `intentionally_invalid`.
- A registry always enforces itself (it is a config object in `config/install`), but registries are
  excluded from the drift/re-import loop (`getEnforcedConfigs(TRUE)`), because they are re-imported
  first, wholesale, by `readRegistriesFromDisk()`.

Discovery: `TargetModuleCollection` finds registries via `configFactory()->listAll('config_enforce.registry')`
in active config, and `ConfigEnforcer::readRegistriesFromDisk()` additionally scans every enabled
module's `config/install` directory on disk so newly deployed registries are picked up on cache rebuild.

Example fixtures live under `tests/modules/config_enforce_*/config/install/`.
