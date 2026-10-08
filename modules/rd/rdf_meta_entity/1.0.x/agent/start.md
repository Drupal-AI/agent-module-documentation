<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RDF Meta Entity (rdf_meta_entity) — agent index
**Stores metadata about an entity in `rdf_meta_entity` meta-entities backed by a SPARQL triplestore.**

- **Version:** 1.0.x (1.0.0-alpha3)
- **Core:** >=9.3 · **PHP:** 7.4
- **Depends on:** meta_entity, sparql_entity_storage
- **Entities:** `rdf_meta_entity` (content) + `rdf_meta_entity_type` (bundle config), SPARQL-backed.
- **Route:** `rdf_meta_entity.type.admin` (`/admin/structure/rdf-meta-entity`) — perm `administer rdf meta entity` (`restrict access: true`).
- **Service:** `rdf_meta_entity.repository` tagged `meta_entity.repository`.
- **Permissions:** `RdfMetaEntityPermissionProvider` (extends Meta Entity provider) generates per-bundle perms.

**Security:** Single admin route is permission-gated and access-restricted; no anonymous, mutating, or public endpoints; entity CRUD uses standard access handlers. No security findings.
