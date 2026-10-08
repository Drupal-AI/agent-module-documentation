# Configure Node Weight

## Global settings — `node_weight.settings`

Form: `src/Form/NodeWeightForm.php` (route `node_weight.form`, the `configure` target) at
`/admin/config/node-weight`. Defaults in `config/install/node_weight.settings.yml` (there is no config
schema shipped).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `checked_node_types` | array | `[]` | Machine names of content types that have node weight enabled. |
| `min_weight` | int | `-10` | Lowest assignable weight (field `min` + widget range floor). |
| `max_weight` | int | `10` | Highest assignable weight. Validated: must be `> min_weight`. |
| `include_unpublished` | bool | `1` | Whether the order screen lists unpublished nodes. |

Checking a type in this form (or setting min/max) calls `node_weight_create_field_node_weight()` for
each enabled type; unchecking calls `node_weight_delete_field_node_weight()`.

## Enabling per content type

Two entry points, both driving `node_weight_content_type_form_submit()`:

1. **Settings form** checkboxes (above).
2. **Node-type edit/add form** — `hook_form_node_type_edit_form_alter()` /
   `..._add_form_alter()` inject a "Node weight settings" details group with an *Enable weight*
   radios element (access-gated by `administer node weight`).

Enabling a type: adds it to `checked_node_types` and creates a `FieldConfig` for
`field_node_weight` on that bundle; disabling removes it from config and deletes the bundle's field.

## The field: `field_node_weight`

- Storage `config/install/field.storage.node.field_node_weight.yml`: entity `node`, type `integer`,
  cardinality 1, **`locked: true`**, `persist_with_no_fields: true`, module `node_weight`. Shared
  across all enabled bundles.
- `node_weight_create_field_node_weight()` creates the per-bundle `FieldConfig` (label "Weight",
  default 0, `settings.min`/`settings.max` from config) and sets the form-display component to the
  `weight_selector` widget. If the field already exists it just refreshes min/max.

## The `weight_selector` widget

`src/Plugin/Field/FieldWidget/WeightSelectorWidget.php` (`@FieldWidget id "weight_selector"`, for
field types `weight` and `integer`): renders a `select` whose options are `range(min, max)`, defaulting
to the current value or 0. This lets editors set weight inline on the node edit form.

## The "Manage order" screen

`src/Form/NodeOrderForm.php` (route `node_weight.order`, path
`/admin/structure/types/manage/{node_type}/order`):

- If the type isn't enabled, shows an "Enable" button (`submitFormEnableNodeWeight`).
- Otherwise builds a `#tabledrag` table of the type's nodes for the current language, sorted by
  weight, each row: title link, language, enabled checkbox, a `weight` element (delta 100), and
  edit/delete operations. `include_unpublished` controls whether unpublished nodes appear.
- Submit sets up a batch (`NODES_PER_BATCH_RUN = 25`) → `batchProcessNodes()` writes changed
  `field_node_weight` and `status`, calling `$node->setNewRevision(FALSE)` so ordering does **not**
  create new revisions.

## Sorting content by weight

Add `field_node_weight` as a **sort criterion** in a View (ascending) to order a listing by the manual
weights. The field is a normal integer field, so it also works in entity queries and elsewhere.
