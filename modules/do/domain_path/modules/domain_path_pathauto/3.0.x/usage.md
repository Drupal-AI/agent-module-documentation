Domain Path Pathauto integrates Pathauto with Domain Path so that automatic URL aliases are generated **per domain**. Each domain-path field gains a "Generate automatic URL alias" checkbox, and Pathauto patterns are applied and made unique independently for every domain.

---

Without this submodule Pathauto produces a single automatic alias per entity per language. Domain Path Pathauto extends that so each domain the entity is published to gets its own automatically generated alias, with uniqueness enforced per domain (a clashing alias becomes `-0`, `-1`, …). It works by decorating two Pathauto services — `pathauto.generator` (with `DomainPathautoGenerator`, which intercepts `updateEntityAlias()` to also generate a domain alias for each domain_path field item whose pathauto state is CREATE) and `pathauto.alias_storage_helper` (with `DomainAliasStorageHelper`, adding domain-aware save/load) — plus a standalone `domain_path_pathauto.alias_uniquifier` for per-domain uniqueness. Via `hook_field_info_alter()` and `hook_field_widget_info_alter()` it replaces the domain_path field/list/widget classes (`DomainPathautoItem`, `DomainPathautoFieldItemList`, `DomainPathautoWidget`) so each per-domain alias input gains an automatic/manual toggle. The automatic-vs-manual state is stored **per domain, per entity** in the key-value store using domain-scoped collections named `domain_path_pathauto_state.{domain_id}.{entity_type}`. Cleanup hooks purge that state and the aliases when an entity or a whole domain is deleted. The module sets its weight to 11 so it runs after Pathauto (weight 10). It has no config or UI of its own; `hook_pathauto_alias_alter()` / `hook_pathauto_pattern_alter()` receive a `domain_id` in their `$context` when invoked for a domain alias. Depends on domain_path and pathauto.

---

- Automatically generate a Pathauto alias for every domain a node is published to.
- Enforce alias uniqueness independently on each domain (append `-0`, `-1`, …).
- Toggle automatic vs. manual alias per domain via the widget checkbox.
- Keep automatic aliases on some domains while hand-writing others for the same node.
- Reuse existing Pathauto patterns across all domains without per-domain pattern config.
- Override a domain's automatic alias by unchecking its "Generate automatic URL alias" box.
- Track pathauto automatic/manual state separately per domain and entity type.
- Purge a domain's pathauto state automatically when the domain is deleted.
- Purge an entity's domain aliases and pathauto state when the entity is deleted.
- Alter a domain-specific generated alias with `hook_pathauto_alias_alter()` (context has domain_id).
- Alter the pattern per domain with `hook_pathauto_pattern_alter()` (context has domain_id).
- Bulk-generate per-domain aliases through Pathauto's generation flow.
- Ensure the submodule runs after Pathauto (module weight 11).
- Provide SEO-friendly automatic URLs on each storefront/brand domain.
- Let editors flip a single domain to a manual alias without affecting others.
- Store automatic-alias state in domain-scoped key-value collections.
- Combine hand-crafted default aliases with automatic per-domain aliases.
- Regenerate a domain's aliases when its pattern changes (via Pathauto bulk update).
- Keep cross-domain links pointing at each domain's automatically generated alias.
- Support translations with per-language, per-domain automatic aliases.
- Decorate Pathauto's generator/storage helper transparently (no Pathauto patches).
- Uniquify aliases within a domain using the dedicated alias uniquifier service.
