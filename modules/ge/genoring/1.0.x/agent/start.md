<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GenoRing (genoring) — agent index
**Biological-data management framework: Dataset entities + a data locator/processor ingestion pipeline.**

- **Version:** 1.0.x (1.0.0-alpha6 release)
- **Core:** ^10.3 || ^11.0
- **Depends:** drupal:file, xnttdm:xnttdm
- **Configure:** `genoring.dashboard` (/genoring)
- **Entity:** `genoring_dataset` (custom access handler grants `view` to all)
- **Plugin types:** DataLocator (Default/Metadata/Taxonomy/MetadataTerm), DataProcessor (Gff3)
- **Services/events:** `genoring.taxonomy`, `GenoringEvents` + subscriber
- **Permissions:** `administer genoring`; dashboard uses `access administration pages`
- **Submodule:** genoring_jbrowse (JBrowse integration)

**Security:** management routes are gated by `administer genoring` / `access administration pages` / per-entity access. One route, `genoring.taxonomy_autocomplete` (`TaxonomyController::handleAutocomplete`), is `_access: 'TRUE'` — an unauthenticated but **read-only** taxonomy autocomplete (returns organism/taxonomy term matches only; no mutation). The dataset access handler allows `view` for everyone, but no anonymous route exposes individual datasets.

See [configure/manage.md](configure/manage.md).
