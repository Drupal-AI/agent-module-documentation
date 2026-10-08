<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Normalizer — agent index

Developer library that prepares configuration for meaningful comparison. Wrap any config
storage in a **`NormalizedReadOnlyStorage`** and every `read()` comes back normalized (sorted,
volatile props reconciled). No admin UI (`configure: null`), no permissions, no Drush, no config
entity.

- **The three normalizer plugins (`active`, `sort`, `filter_format`) and how to add one** →
  [plugins/normalizers.md](plugins/normalizers.md)
- **Normalize a storage/item in code: `NormalizedReadOnlyStorage`, the `context`
  (mode + reference storage), `ConfigItemNormalizer`, `NormalizedStorageComparerTrait`** →
  [api/normalized-storage.md](api/normalized-storage.md)

Key facts:
- Plugin type dir `Plugin/ConfigNormalizer`, manager `plugin.manager.config_normalizer`,
  annotation `@ConfigNormalizer`, base `ConfigNormalizerBase`.
- Shipped plugins: `active` (w0, copies uuid/_core from active), `sort` (w20, recursive sort),
  `filter_format` (w20, strips `roles` from `filter.format.*`).
- Context: `normalization_mode` = `compare` (default) or `provide`; `reference_storage_service`.
  Sorting only runs in the default/compare mode.
