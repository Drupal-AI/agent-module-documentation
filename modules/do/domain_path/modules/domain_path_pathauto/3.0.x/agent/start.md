# Domain Path Pathauto — agent index

Makes Pathauto generate automatic URL aliases **per domain** for Domain Path fields. Decorates
Pathauto services; adds a per-domain "Generate automatic URL alias" toggle; stores auto/manual
state in the key-value store. No config or UI of its own. Depends on **domain_path** +
**pathauto**. See the parent module for how domain aliases are stored:
[../../../../3.0.x/agent/api/aliases.md](../../../../3.0.x/agent/api/aliases.md).

- **Service decorators, field/widget class overrides, the per-domain pathauto state store,
  generation flow, and the hooks it exposes** → [api/pathauto-integration.md](api/pathauto-integration.md)

Key facts: decorates `pathauto.generator` (→ `DomainPathautoGenerator`) and
`pathauto.alias_storage_helper` (→ `DomainAliasStorageHelper`); standalone
`domain_path_pathauto.alias_uniquifier`. Per-domain auto/manual state lives in key-value
collections **`domain_path_pathauto_state.{domain_id}.{entity_type}`**. Module weight is 11
(after Pathauto's 10). `hook_pathauto_alias_alter()`/`hook_pathauto_pattern_alter()` receive a
`domain_id` in `$context` for domain aliases.
