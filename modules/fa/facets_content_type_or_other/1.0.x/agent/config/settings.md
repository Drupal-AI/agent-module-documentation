<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config

Class `Drupal\facets_content_type_or_other\Form\SettingsForm` (`src/Form/SettingsForm.php`), extends
`ConfigFormBase`. Form id `facets_content_type_or_other_settings_form`.

## Route & access

- Route `facets_content_type_or_other.settings` (`facets_content_type_or_other.routing.yml`),
  path `/admin/config/search/facets-content-type-or-other`, title *Content type or Other settings*.
- Requirement `_permission: 'administer facets'` (from the Facets module; this module defines no
  permission of its own).
- Menu link `facets_content_type_or_other.settings` (`*.links.menu.yml`) under `system.admin_config_search`,
  weight 31.
- Standard `ConfigFormBase` → POST submission with core CSRF token; no state-changing GET.

## Config object

Edits `facets_content_type_or_other.settings` (`getEditableConfigNames()`). No `config/install` default and
**no `config/schema`** ship with the module — the object is created on first save.

Stored key `first_order_config` is an array keyed by node-type machine name, each row:

- `first_order` (checkbox) — whether the type is a first-order value (else folded into "Other").
- `label_override` (textfield, defaults to the node type label) — the label indexed/displayed for the type.
- `weight` (number) — sort weight used by the sort processor.

## Build (`buildForm`)

Injects `entity_type.manager` (via `create()`) and uses `node_type` storage. Builds a draggable
`#type => 'table'` (`id` `first-order-config-table`, tabledrag group `foct-sort-weight`) with a row per
content type: plain-text label, first-order checkbox, label-override textfield, and a weight number field.
Rows are pre-sorted by `SortArray::sortByWeightProperty` before rendering. Each row id is
`Html::cleanCssIdentifier("foct-{$key}")`.

## Submit (`submitForm`)

Re-sorts the submitted `first_order_config` by `SortArray::sortByWeightElement`, then saves it to the config
object.

## Operating notes

- `hook_help()` (in `.module`) reminds admins to select **Content type or Other - Sort order** under the
  facet's sorting and to **re-index all content after saving** for changes to apply.
- The saved `first_order_config` is consumed by both plugins:
  [../plugins/search-api-processor.md](../plugins/search-api-processor.md) (label mapping) and
  [../plugins/facets-sort-processor.md](../plugins/facets-sort-processor.md) (order).
