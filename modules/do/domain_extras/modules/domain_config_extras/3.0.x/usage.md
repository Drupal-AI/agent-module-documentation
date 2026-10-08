Domain Configuration Extras provides a helper service that reads back the per-domain (and per-domain-per-language) configuration overrides stored by the Domain config module.

---

Domain Configuration Extras is a small utility module with no UI, routes, permissions, config, or hooks — its `.module` file is empty. It ships one autowired service, `domain_config_extras.utilities` (`Drupal\domain_config_extras\DomainConfigUtilities`), constructed with the `config.storage` service plus the entity type manager and language manager. Its single public method, `loadAllDomainOverrides(array $names, bool $only_active = FALSE)`, iterates domain entities (all, or only those with `active = 1`) and, for each, opens the domain's config collection — named via `DomainConfigCollectionUtils::createDomainConfigCollectionName()` — and each domain+language collection (via `createDomainLanguageConfigCollectionName()`), reading any of the requested config `$names` that exist there. It returns a nested array keyed by config name, then domain id, then `'default'` (domain-level override) or a language id (domain+language override), with the raw override data as the value. Domain storage is resolved at call time through the entity type manager rather than cached, so a container rebuild cannot leave a stale handler. Depends on `domain:domain_config` (and transitively the base Domain suite).

---

- Read all per-domain config overrides for one or more config names in a single call.
- Inspect what a given domain overrides for `system.site`, a view, a block, etc.
- Restrict the lookup to active domains only with `$only_active = TRUE`.
- Retrieve domain+language overrides alongside plain domain overrides.
- Build an audit or report of which domains customize which configuration.
- Compare override values across domains programmatically.
- Feed override data into a Drush command or custom admin screen.
- Discover which languages a domain has language-specific overrides for.
- Get the raw stored override arrays (not merged runtime config) for diffing.
- Detect domains that have no override for a given config name (absent keys).
- Resolve domain config collection names without hand-building the strings.
- Iterate every domain's config collection without writing storage plumbing yourself.
- Inject `domain_config_extras.utilities` into your own service to reuse the loader.
- Support migration or cleanup scripts that need the full override picture.
- Verify that expected per-domain overrides were actually written to storage.
