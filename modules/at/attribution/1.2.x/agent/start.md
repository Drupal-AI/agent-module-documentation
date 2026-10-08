# Attribution — agent index

Attach author/source/license **and AI-provenance** metadata to fieldable entities via an
`attribution` field type (4 widgets, 7 formatters), plus site-wide **Attribution** and
**Copyright** blocks. Licenses are `attribution_license` config entities imported from the SPDX
list. Config UI at `/admin/structure/attribution-license`
(`configure` = `entity.attribution_license.collection`, perm `administer attribution_license`).
No Drush, no custom plugin types. Depends on core `field`.

- **License config entity, importing SPDX licenses, the admin UI + permission, default licenses, per-field license restriction** → [configure/licenses.md](configure/licenses.md)
- **The `attribution` field type (properties/schema, AI provenance), widgets, formatters (incl. the new configurable Default), and the two blocks** → [api/field-and-blocks.md](api/field-and-blocks.md)

Key facts:
- Field type `attribution` (`src/Plugin/Field/FieldType/AttributionItem.php`): 10 properties —
  `source_name`, `source_link` (uri), `author_name`, `author_link` (uri), `license` (license id),
  and (new in 1.2) `creation_type`, `ai_tool`, `ai_prompt` (long text), `prompt_editor_name`,
  `prompt_editor_link` (uri). Creation types: `human_created`, `ai_generated`, `ai_modified`.
  Default widget `attribution_source_author_license`; **default formatter `attribution_default`**
  (was `attribution_creative_commons` in 1.1).
- Config entity `attribution_license` (config prefix `attribution.attribution_license`): `id`,
  `identifier` (SPDX), `name`, `osiCertified` bool, `deprecated` bool, `link`. 10 defaults ship
  (adds `unknown_unasserted`).
- SPDX import form `AttributionLicensesForm` at route `entity.attribution_license.select_form`
  (`/add`) reads `composer/spdx-licenses` (400+). Blank custom license = entity form at
  `entity.attribution_license.add_form` (`/add-custom`).
- Blocks `attribution` and `attribution_copyright` (`src/Plugin/Block/`) render a disclaimer with
  Token + `@name`/`@link` placeholders. Depends only on core (+ optional `token`).
- `attribution_update_10001` adds the five AI columns to existing fields and installs the
  `unknown_unasserted` license.
