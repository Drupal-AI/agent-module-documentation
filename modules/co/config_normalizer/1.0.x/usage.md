<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Normalizer processes configuration to prepare it for meaningful comparison: it wraps any config storage in a read-only storage that returns each item in a normalized form (sorted, with volatile properties reconciled), so diffs between two storages show only real differences.

---

The module defines a `ConfigNormalizer` annotation plugin type (`Plugin/ConfigNormalizer`, manager `plugin.manager.config_normalizer`) and ships three plugins run in weight order: `active` (weight 0) copies `uuid` and `_core` from a reference active storage onto the data so those core-set properties don't register as differences; `sort` (weight 20) recursively sorts arrays (associative arrays by key, indexed arrays by value); and `filter_format` (weight 20) strips the `roles` element from `filter.format.*` items, which is valid only on exported config. `ConfigItemNormalizer` applies every normalizer plugin to a single config item, and `NormalizedReadOnlyStorage` is a `ReadOnlyStorage` decorator that runs that normalization on every `read()`/`readMultiple()`. Normalization is driven by a `context` array with `normalization_mode` (`compare` — the default — or `provide`) and a `reference_storage_service`; write-inappropriate transforms like sorting only run in the default/compare mode, while `provide` mode keeps data safe to write back. The `NormalizedStorageComparerTrait` gives a class a `createStorageComparer()` that builds a core `StorageComparer` over two `NormalizedReadOnlyStorage`-wrapped storages. The module has no admin UI (`configure: null`), no permissions, no Drush, and no config entity of its own — it is a developer library used by tools like Configuration Update Manager, Features, and Config Distro.

---

- Compare two config storages (e.g. active vs sync) so that only meaningful differences show up.
- Ignore `uuid`/`_core` churn when diffing config saved to the active store against exported files.
- Recursively sort config arrays so key order differences don't appear as changes.
- Strip the export-only `roles` element from filter formats before comparing them.
- Wrap the sync storage in a normalized read-only storage for a custom config-diff UI.
- Build a `StorageComparer` over normalized storages via `NormalizedStorageComparerTrait::createStorageComparer()`.
- Minimize false positives in a "configuration has changed" check on a deployment pipeline.
- Normalize config before hashing it to detect genuine drift (ignoring cosmetic reordering).
- Provide config in `provide` mode where sorting is skipped so the result stays safe to write.
- Add a custom `ConfigNormalizer` plugin to reconcile another volatile property for your entity type.
- Underpin Features/Config packaging by comparing packaged config against active config cleanly.
- Reconcile install-time property differences when checking whether shipped config matches active.
- Normalize a single config item programmatically with `ConfigItemNormalizer::normalize()`.
- Feed normalized storages into Config Distro / Config Sync so distribution diffs are accurate.
- Weight a new normalizer relative to `active`, `sort`, and `filter_format` to control ordering.
- Read a config item normalized against a specific reference storage via the context array.
- Detect whether the reference storage is the active storage (the `active` plugin uses this) for install-parity normalization.
- Prepare two arbitrary storages for a byte-stable comparison in tests.
- Avoid re-implementing recursive sort + property reconciliation in every config-diff tool.
- Present cleaner diffs to site builders reviewing configuration updates.
