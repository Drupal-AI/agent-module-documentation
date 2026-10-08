<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Organization (drutopia_organization) — agent index

**Config-only Features module: installs an `organization` node type (groups/nonprofits/businesses), its fields, displays, a Search API listing view, taxonomies, pathauto and a contributor role grant.** Part of the Drutopia distribution.

- **Version:** 2.0.x (installed here as a **dev checkout** — `info.yml` has no `version:`; dir tracks the 2.0.x dev branch). **Core:** `^10.2 || ^11 || ^12`. **Package:** Drutopia. **License:** GPL-2.0-or-later.
- **No PHP.** No `src/`, routes, services, hooks, `*.install`, `permissions.yml` or `config/schema/`. Everything is config in `config/install/`, `config/optional/` and `config/actions/`, plus a Features manifest and one action link.
- **In this project the module did NOT enable** — the Drutopia dependency chain (drutopia_core/event/seo etc.) is not present. This is **expected**; these docs are written from the on-disk source, and enabling is not required to document a config-only feature.

## Dependencies (info.yml)
drutopia_core, drutopia_event, drutopia_seo, ds, facets, field_group, focal_point, metatag, paragraphs, inline_entity_form, ief_complex_open, pathauto, search_api, entity_reference_revisions, block_visibility_groups, ctools + core block/field/image/menu_ui/node/path/responsive_image/taxonomy/text/user/views. Composer `require` also lists drupal/drutopia_core, drutopia_seo, ds, field_group, ief_complex_open, inline_entity_form, pathauto, paragraphs.

## What it ships (all configuration)
- **Content type** `organization` (`node.type.organization`) — new revisions, preview on, submitted-by off, addable to `main` menu.
- **Fields** — `title` relabelled "Organization name" (required), `field_summary` (required text_long), `body` (text_with_summary), `field_body_paragraph` ("Description", paragraphs / entity_reference_revisions), `field_image` (image, focal point, alt required), `field_organization_type` (ref → organization_type vocab), `field_topics` (ref → topics vocab), `field_meta_tags` (metatag). Storages defined here: `field_organization_name`, `field_organization_type` (others come from drutopia_core). Note: `field_organization_name` storage has **no** field instance (vestigial).
- **Displays** — 1 form display (`default`, with `inline` form mode) + 5 view displays: `default`, `full`, `teaser`, `small_card`, `search_index` (Display Suite layouts).
- **Listing** — `search_api.index.organization` (server `database`) + `views.view.organization` (title "Our organization", page `page_listing` at `/organization`, rows = `small_card`, grouped by organization type, access perm `access content`) + `facets.facet.organization` (attached to the **event** listing's search source, field `field_organization`).
- **Taxonomies** — `organization`, `organization_type` vocabularies. **Pathauto** — `organization_node` (`organization/[node:title]`), `organization_type` (`[term:vocabulary]/[term:name]`).
- **Optional** (`config/optional/`) — adds `field_organization` (multi-value node ref → organization) to the **Event** content type.
- **Action link** — `drutopia_organization.add_organization` → `node.add/organization`, shown on `view.organization.page_listing`.
- **Role grant** (`config/actions/user.role.contributor.yml`) — appends `create organization content`, `edit own organization content`, `delete own organization content` to role `contributor`.

## Solution docs
- **Full content model, fields, displays, listing view, taxonomies, pathauto, the Event reference, and the contributor grant** → [config/content-model.md](config/content-model.md)

## Security
Configuration-only; no custom routes/controllers, no permissions defined, no external calls. Node access follows standard node permissions/workflow. No findings.
