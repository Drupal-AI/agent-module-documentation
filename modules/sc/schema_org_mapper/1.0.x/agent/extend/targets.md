<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapping and extending

## Enable
1. Enable the base `schema_org_mapper` engine (no entity type on its own).
2. Enable the submodule(s) for the entities you use: `schema_org_mapper_node`, `_taxonomy`, `_block`, `_views`.
   Each exposes a **Schema.org Mapper** tab on its bundles.

## Map a bundle (`BundleSchemaForm`, perm `administer schema_org_mapper`)
- Choose the Schema.org type (Product, Article, Event, Place, …) from the curated catalog (43 types / 155 properties).
- For each property choose a source: an entity field, a fixed value, or a token. Unmapped → omitted.
- Supports nested objects and ordered multi-value lists (FAQ, breadcrumbs). JSON-LD is emitted in `<head>` at render.

## Add your own target (developers)
Implement `hook_schema_org_mapper_target_info()` to declare an entity type/bundle target; the base module's
`TargetRoutes::routes` and the `SchemaTargetTasks` derivative generate the per-bundle tab automatically.
`schema_org_mapper.api.php` documents the hook.
