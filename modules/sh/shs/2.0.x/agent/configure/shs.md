# Configure the SHS widget, formatter & Views filter

SHS has **no global admin page** (no `configure` route). It is configured per field, on the
entity's *Manage form display* and *Manage display* tabs, and per view.

## Enable the cascading widget on a field

1. Add or reuse an **entity-reference** field whose target type is `taxonomy_term` and whose
   handler targets **exactly one vocabulary** (`target_bundles` has a single bundle). SHS's
   `isApplicable()` refuses fields that target multiple bundles or non-term entities.
2. On **Manage form display**, set that field's widget to **Simple hierarchical select**
   (plugin id `options_shs`). For Chosen styling use **Simple hierarchical select: Chosen**
   (`options_shs_chosen`, needs the `shs_chosen` submodule).

On the form the field renders as a chain of `<select>` boxes: choosing a parent term reveals a
new dropdown of its children; the deepest choice is stored. Multi-value fields get an "Add
another item" control that adds another hierarchical selector row.

## Widget settings (`field.widget.settings.options_shs`)

Config schema keys (all booleans, default `false`):

| Key | Meaning |
|---|---|
| `force_deepest` | Require the user to select a term from the **deepest** level (a leaf). Enforced client-side and again server-side in `OptionsShsWidget::validateElement()`. |
| `create_new_items` | Allow creating new terms from within the widget. **Present in schema but the checkbox is disabled** in this release (feature not implemented). |
| `create_new_levels` | Allow creating a child under a term that has none yet. **Also disabled** in the settings form. |
| `display_node_count` | Show a node count per option (schema key). |

Because there is no admin form, set these in the field's form-display config
(`core.entity_form_display.*`), e.g. via `drush config:edit` or config export/import. Note:
"Add another item" (multi-value) is a separate mechanism from `create_new_items`; the latter
(creating actual taxonomy terms in-widget) is not active in 2.0.x.

## The AJAX children endpoint

Each level's options are loaded on demand — not rendered up front. Route **`shs.term_data`**:

```
/shs-term-data/{identifier}/{bundle}/{entity_id}
  controller: \Drupal\shs\Controller\ShsController::getTermData
  _permission: access content
  entity_id defaults to 0 (top level)
```

`getTermData()` loads **one level** of the tree (`TermStorage::loadTree($bundle, $parent, 1)`)
and returns a cacheable JSON array of objects: `tid`, `name`, `description__value`, `langcode`,
and `hasChildren` (whether another dropdown should appear). Unpublished terms are filtered out
unless the user has `administer taxonomy` or `view unpublished terms in <bundle>`. When content
translation is enabled for the vocabulary, term names are returned in the current content
language. The widget passes `baseUrl: 'shs-term-data'` to the JS, which calls this endpoint with
the parent term id as it descends.

## Read display — the `entity_reference_shs` formatter

On **Manage display**, choose **Simple hierarchical select** (`entity_reference_shs`) to render a
stored term as its full ancestry (root → … → selected) as an `item_list`. Its one setting,
`link`, wraps each ancestry label in a link to the referenced term.

## Views exposed filter

SHS overrides the core filters `taxonomy_index_tid` and `taxonomy_index_tid_depth` (via
`hook_views_plugins_filter_alter`) so the exposed **"Has taxonomy terms"** / **"Has taxonomy
terms (with depth)"** filters can be exposed as the same cascading hierarchical select. If
Search API is installed, its `search_api_term` filter is likewise swapped to the SHS class.
