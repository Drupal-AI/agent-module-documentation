<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Schema.org Mapper (schema_org_mapper) — agent index
**Maps entity fields to Schema.org properties and outputs JSON-LD in the page head, per bundle, via submodules.**

- **Version:** 1.0.x  **Core:** ^10 || ^11  **Depends:** field
- **Base route:** `schema_org_mapper.settings` (`/admin/config/search/schema-org-mapper`) — READ-ONLY overview, perm `administer schema_org_mapper`.
- **Dynamic per-bundle tabs:** `TargetRoutes::routes` + `SchemaTargetTasks` derivative, from targets declared by submodules via `hook_schema_org_mapper_target_info`.
- **Submodules:** `schema_org_mapper_node`, `_taxonomy`, `_block`, `_views`. **Form:** `BundleSchemaForm`. **Catalog:** 43 types / 155 properties.
- **Security:** mapping config requires the restricted `administer schema_org_mapper`; base settings page is informational only; output is read-only JSON-LD from existing content. No anonymous or mutating endpoints. Sound.

See [extend/targets.md](extend/targets.md)
