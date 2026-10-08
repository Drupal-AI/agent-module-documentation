<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN extra fields — placing, rendering and theming

All logic lives in `dkan_extra_fields.module`. There are no classes, routes, permissions or config objects owned by this module.

## Install / enable
1. Apply the bundled `4310-plus.patch` to DKAN (patched in `composer.json` `extra.patches` against `drupal/dkan`). It edits `dkan_metastore/modules/dkan_metastore_search/src/ComplexData/Dataset.php` so referenced-schema properties get `_Ref_<property>__identifier` definitions and array/sub-item values resolve.
2. `drush en dkan_extra_fields` — pulls in `dkan_metastore_search` (declared dependency).
3. Go to the `data` content type display, e.g. `admin/structure/types/manage/data/display`, and move the desired `Dataset property: …` extra fields out of *Disabled*.

## Extra field registration — `hook_entity_extra_field_info()`
Instantiates `new \Drupal\dkan_metastore_search\ComplexData\Dataset('')` and iterates `getProperties()`. Each `TypedData` property registers a display component:
`$extra['node']['data']['display']['dataset_' . $property_key]` with label `Dataset property: @label (@property)`, `weight 0`, `visible FALSE` (hidden until placed). The `node`/`data` bundle and the `dataset_` prefix are hard-coded.

## Rendering — `hook_node_view()`
Runs only when: entity is a `node`, bundle is `data`, it has a non-empty `field_data_type` equal to `'dataset'`. Then:
- Builds `new Dataset($entity->get('field_json_metadata')->value)` and decodes the `dataset` schema via `\Drupal::service('dkan.metastore.schema_retriever')` (`\Drupal\dkan_metastore\SchemaRetriever::retrieve('dataset')`).
- For each property, only renders it if the display has that component (`$display->getComponent('dataset_' . $property_key)`), so hidden fields cost nothing.
- Branches by value shape:
  - **ItemList** (`\Drupal\Core\TypedData\Plugin\DataType\ItemList`) → a `dkan_extra_field` wrapper whose `#items` is an `item_list`; integer-typed items become a `dkan_extra_field_item` (multi-property row) built from `$dataset->getValue()->{$property_key}[$value]`.
  - **string** → `dkan_extra_field` with a single `#markup`.
  - **object** → a `container` with one `dkan_extra_field` per sub-property.
  - **array** → a `container` grouping items per inner property.
  - **enum** → wherever the schema (or item schema) defines `enum`, the value is mapped to its `enumNames` label and rendered via `dkan_extra_field_enum`.
- Labels/base-labels come from the decoded schema `title`s; `__item__` / `__` in a property key select nested schema titles.
- Empty containers/lists get `#access = FALSE`.

## HTML escaping
Values become `#markup`. In the string and list branches the code sets `$markup['#allowed_tags'] = []` (strip all tags → plain text) **unless** the property key is present in the DKAN metastore allowlist `\Drupal::config('dkan_metastore.settings')->get('html_allowed_properties')` (keyed by `<property_key>` or `dataset_<property_key>`). That allowlist belongs to DKAN metastore, not this module; opting a property in is an explicit admin choice to permit HTML. Enum labels come from trusted schema `enumNames`, and the Twig templates autoescape their variables.

## Theme hooks & suggestions (`hook_theme()` + `hook_theme_suggestions_HOOK()`)
- `dkan_extra_field` (`templates/dkan-extra-field.html.twig`) — vars `base_label`, `label`, `items`, `variator`, `enum_label`, `view_mode`.
- `dkan_extra_field_enum` (`templates/dkan-extra-field-enum.html.twig`) — vars `value`, `label`, `variator`, `view_mode`; renders `label / value`, or a `target=_blank` link when a `link` var is set.
- `dkan_extra_field_item` (`templates/dkan-extra-field-item.html.twig`) — vars `property`, `view_mode`, `data_type`, `keys`, `items`; loops `items`, showing each key when `keys[key].show`, with optional `keys[key].label` and `keys[key].date` (date format).
- Suggestions are generated from `variator`/`property` plus `data_type`/`view_mode`, e.g. `dkan_extra_field__<variator>`, `dkan_extra_field__<variator>__<view_mode>`, `dkan_extra_field_item__<property>__<data_type>__<view_mode>` — override any of these in a theme.

## Customize
Use `hook_preprocess_dkan_extra_field_item()` to tune per-key output: inspect `$variables['keys']`, set `['show' => FALSE]` to hide a key, change `['label' => …]`, or add `['date' => <format>]` to format a timestamp. This is the documented extension point (README `CUSTOMIZATION`).

## Gotchas
- Nothing renders unless the node is bundle `data` with `field_data_type` = `dataset` and the schema retriever returns the `dataset` schema.
- The DKAN patch is mandatory; without it the referenced-schema/array property definitions the render loop expects are missing.
- The metastore `html_allowed_properties` config key must match exactly (`dataset_<property_key>`); list-branch lookups are strict, so HTML opt-in mainly applies to plain string properties.
