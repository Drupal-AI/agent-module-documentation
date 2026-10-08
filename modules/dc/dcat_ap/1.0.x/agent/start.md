<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DCAT-AP (dcat_ap) — agent index

**Extends the base [`dcat`](../../../dcat/2.0.x/agent/start.md) module with the DCAT-AP 2.1.0 application profile. Adds profile-specific base fields to the DCAT dataset/distribution entities and enforces DCAT-AP mandatory/recommended constraints on dataset, distribution and agent — all via three `dcat_field_provider` plugins.**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** `^10 || ^11` · Package `DCAT` · License GPL-2.0-or-later
- **Depends on:** `dcat:dcat` (hard dependency; provides the entities and the `dcat_field_provider` plugin type)
- **Configure:** none of its own (no routes, permissions, services, or admin UI)

## What it actually is

- No new entity types, routes, controllers, permissions, services, hooks (other than `hook_install`), or config schema. It is purely a set of **plugins of the base module's `dcat_field_provider` type** (weight 5 each) plus optional display config.
- Three plugins in `src/Plugin/DcatFieldProvider/`, each extending `Drupal\dcat\DcatFieldProviderBase` and annotated with the `#[DcatFieldProvider]` attribute:
  - `DcatApDatasetFields` (id `dcat_ap_dataset_fields`, entity_type `dcat_dataset`) — adds 6 fields; makes description + publisher required.
  - `DcatApDistributionFields` (id `dcat_ap_distribution_fields`, entity_type `dcat_distribution`) — adds 2 fields; updates title/access-URL/format/media-type/status descriptions.
  - `DcatApAgentFields` (id `dcat_ap_agent_fields`, entity_type `dcat_agent`) — no new fields; makes name required, rebuilds `type` as an `eu_corporate_body` taxonomy reference.
- `dcat_ap.install` `hook_install()` loads dcat's install include and calls `dcat_sync_entity_schemas()` so the added/altered fields are actually written to the (pre-existing) entity tables.
- `config/optional/` ships default entity form + view displays for the new dataset and distribution fields; applied only when the base default displays and the `link`/`text` modules are present.

## Fields added (all optional/DCAT-AP terms)

- **Dataset:** `dcat_ap_version_info` (string, owl:versionInfo), `dcat_ap_is_version_of` (link, dcterms:isVersionOf), `dcat_ap_has_version` (link, multi, dcat:hasVersion), `dcat_ap_source` (link, multi, dcterms:source), `dcat_ap_provenance` (string_long, multi, dcterms:provenance), `dcat_ap_sample` (entity_reference→dcat_distribution, multi, adms:sample).
- **Distribution:** `dcat_ap_checksum` (string, spdx:checksum, "algo:hash" format), `dcat_ap_representation_technique` (link, adms:representationTechnique).

## Constraints applied (via `alterFieldDefinitions`)

- **Made required:** dataset description + publisher; distribution title (already required in base) + access URL (already required in base); agent name.
- **Recommended-vocabulary description updates only:** dataset theme (EU Data Theme); distribution format (EU file-type), media type (IANA), status (ADMS status); agent type (EU Corporate Body — rebuilt as taxonomy reference).

See **[plugins/field-providers.md](plugins/field-providers.md)** for the full field list, constraints, the install hook, and how to operate it.

## Security

No routes, no controllers, no user-facing input handling, no external calls, no permissions. Access to the underlying entities is entirely governed by the base dcat module's per-type access handlers. No adversarial surface introduced.
