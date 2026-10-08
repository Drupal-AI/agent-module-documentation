# Domain Configuration Extras (domain_config_extras) 3.0.x

Utility service for reading back the per-domain and per-domain-per-language configuration overrides created by the Domain config module. No UI.

## Facts

- **Dependencies:** `domain:domain_config` (info.yml); transitively pulls the base Domain suite. `core_version_requirement: ^10.2 || ^11`.
- **Routes / UI:** none.
- **Permissions:** none (no `*.permissions.yml`).
- **Config / schema:** none.
- **Hooks:** none — `domain_config_extras.module` is an empty file (docblock only).
- **Plugins:** defines none.
- **Service:** `domain_config_extras.utilities` → `Drupal\domain_config_extras\DomainConfigUtilities` (`src/DomainConfigUtilities.php`). Autowired (`_defaults: autowire: true` in `domain_config_extras.services.yml`); the `config.storage` arg is wired explicitly as `$configStorage`, while `EntityTypeManagerInterface` and `LanguageManagerInterface` are autowired.
  - **Method** `loadAllDomainOverrides(array $names, bool $only_active = FALSE): array` — for each domain (all, or `active = 1` only when `$only_active`) opens the domain config collection (`DomainConfigCollectionUtils::createDomainConfigCollectionName($domain->id())`) and each domain+language collection (`createDomainLanguageConfigCollectionName($domain->id(), $langId)`), reading any requested `$names` that exist.
  - **Returns:** `[$configName][$domainId]['default'] => data` for a domain override, and `[$configName][$domainId][$langId] => data` for a domain+language override. Absent overrides are simply not keyed.
  - Domain storage is fetched from the entity type manager per call (`domainStorage()`), not cached, to survive container rebuilds.

## How to use

Inject or fetch the service and pass the config names to inspect:

```php
$utils = \Drupal::service('domain_config_extras.utilities');
$overrides = $utils->loadAllDomainOverrides(['system.site'], TRUE);
// $overrides['system.site']['example_com']['default'] => [...]
// $overrides['system.site']['example_com']['de']      => [...]
```

Returns raw stored override arrays (not the merged runtime config), so it is suited to auditing, diffing, and reporting which domains customize which configuration.
