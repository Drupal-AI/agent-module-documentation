<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN extra fields (dkan_extra_fields) — agent index

**Exposes each DKAN JSON Schema property of a dataset as an extra (pseudo) field you can place, order, hide and theme in the field-display UI.**

- **Version:** 4.0.x · **Core:** `^10 || ^11` · **Package:** DKAN · **License:** GPL-2.0-or-later
- **Depends on:** `dkan_metastore_search` (info.yml: `dkan:dkan_metastore_search`); Composer requires `drupal/dkan:^4`.
- **Requires a patch:** bundled `4310-plus.patch` must be applied to DKAN — it fixes referenced-schema property identifiers in `dkan_metastore_search`'s `ComplexData/Dataset`.
- **No** routes, permissions, services, drush commands, plugins, or config of its own. Display-only.

## How it works (all in `dkan_extra_fields.module`)
- `hook_theme()` — registers three theme hooks: `dkan_extra_field`, `dkan_extra_field_enum`, `dkan_extra_field_item` (templates in `templates/`).
- `hook_theme_suggestions_HOOK()` (×3) — generate per-property, per-`data_type`, per-`view_mode` suggestions (e.g. `dkan_extra_field__<variator>__<view_mode>`).
- `hook_entity_extra_field_info()` — for every property of `\Drupal\dkan_metastore_search\ComplexData\Dataset`, registers a hidden display extra field `node.data.display.dataset_<property_key>`.
- `hook_node_view()` — on `data` nodes whose `field_data_type` is `dataset`, parses `field_json_metadata`, retrieves the `dataset` schema via `dkan.metastore.schema_retriever`, and renders each placed `dataset_<property_key>` (string / object / array / ItemList / enum branches).

## Rendering & escaping
- Property values render as `#markup`. String and list branches set `#allowed_tags = []` (tags stripped) unless the property is opted into the DKAN metastore `dkan_metastore.settings:html_allowed_properties` allowlist. Object/array item values render through core's default markup filtering. Enum values resolve to schema `enumNames` labels. Twig templates autoescape.

## Solution docs
- Placing, rendering and theming the extra fields: [`fields/extra-fields.md`](fields/extra-fields.md)
