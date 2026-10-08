<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Schema.org Mapper maps the fields a bundle already has to Schema.org properties and outputs the resulting JSON-LD in the page `<head>`, following the principle "read what is already there; never invent data".

---

You declare what kind of thing each bundle is (Product, Article, Event, Place…) and where each property's value comes from (an entity field, a fixed value, or a token); at render time the module reads the real content and writes JSON-LD. A property with no mapped source is simply omitted, keeping markup aligned with the visible page as Google's structured-data policies require. The base module is an engine that hard-codes no entity type: enabling a submodule (`schema_org_mapper_node`, `_taxonomy`, `_block`, `_views`) exposes a per-bundle "Schema.org Mapper" tab, whose routes are generated dynamically from targets declared via `hook_schema_org_mapper_target_info` (`TargetRoutes::routes`, `SchemaTargetTasks` derivative). A curated catalog (43 types, 155 properties) is prioritized from Google's docs. The base settings page (`/admin/config/search/schema-org-mapper`) is read-only/informational; adding types and mapping properties requires the restricted `administer schema_org_mapper` permission. Values are normalized before output.

Set up by enabling the base module plus the submodule(s) for the entity types you use, then mapping each bundle's Schema.org type and property sources from its Schema.org Mapper tab.

---
- Emit JSON-LD structured data in the page head.
- Map existing fields to Schema.org properties (no re-typing).
- Declare a bundle as Product, Article, Event, Place, etc.
- Source a property from a field, a fixed value, or a token.
- Omit unmapped properties to stay policy-compliant.
- Add structured data to content types (node submodule).
- Add structured data to taxonomy vocabularies.
- Add structured data to custom block types.
- Add structured data to Views listing pages.
- Build nested Schema.org objects.
- Emit ordered multi-value lists (FAQ, breadcrumbs).
- Improve eligibility for Google rich results.
- Use the curated 43-type / 155-property catalog.
- Normalize field values before output.
- Verify output against Google's structured-data tools.
- Extend targets via `hook_schema_org_mapper_target_info`.
- Restrict mapping changes to `administer schema_org_mapper`.
- Keep markup in sync with visible content automatically.
- Map only the entity types you enable submodules for.
- Review status from the read-only settings overview.
