<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DKAN extra fields makes individual JSON Schema properties of DKAN dataset metadata available as pseudo-fields you can place, order, hide and theme in *Manage display*.

---

DKAN stores dataset metadata as a JSON document validated against a schema; those properties are not normally individual Drupal fields. This module registers one extra field per schema property (via `hook_entity_extra_field_info` in `dkan_extra_fields.module`) on the DKAN `data` node bundle, and on node view (`hook_node_view`) reads the dataset's `field_json_metadata`, walks the schema-derived properties, and renders each placed one — plain strings, nested objects, arrays of items, and enum values with their human-readable labels. Rendering goes through three theme hooks (`dkan_extra_field`, `dkan_extra_field_enum`, `dkan_extra_field_item`) that generate many theme suggestions keyed by property, data type and view mode, so a site can style any property differently. HTML in a property value is stripped unless a site admin opts that property into the DKAN metastore `html_allowed_properties` allowlist. The module requires the bundled `4310-plus.patch` applied to DKAN (it fixes referenced-schema property identifiers in `dkan_metastore_search`).

It is a display-only module: no routes, no permissions, no drush commands, no config of its own — it only renders metadata already stored on the entity. Setup: apply the patch, enable the module (which pulls in `dkan_metastore_search`), then arrange the new extra fields on the `data` content type's display, e.g. `admin/structure/types/manage/data/display`.

---
- Show a dataset's publisher, license, contact or description as its own display row.
- Reorder individual schema properties in *Manage display* like real fields.
- Hide schema properties you do not want rendered on the node.
- Render enum property values with their human-readable `enumNames` label via a dedicated theme hook.
- Output multi-property list items (e.g. distributions/resources) together in one extra field.
- Customize labels and per-key visibility via `hook_preprocess_HOOK()` for `dkan_extra_field_item`.
- Theme a property differently per view mode using the generated theme suggestions.
- Expose spatial, temporal or keyword metadata as visible, styled fields.
- Build a tailored dataset detail page assembled from individual schema properties.
- Avoid writing custom Twig or preprocess just to surface JSON metadata.
- Vary output by property key or data type with auto-generated theme suggestions.
- Present keyword/theme tag arrays as readable item lists.
- Add distribution/resource metadata rows to the dataset display.
- Keep the whole layout exportable as per-content-type display config.
- Combine with DKAN metastore search result displays for a consistent look.
- Relabel or hide a property's inner key in a rendered multi-property item.
- Show only selected properties in a teaser or search-result view mode.
- Opt specific properties into HTML output via the metastore `html_allowed_properties` setting.
- Drive a consistent metadata layout across all datasets on the site.
- Surface referenced-schema identifiers (via the bundled DKAN patch) as displayable fields.
