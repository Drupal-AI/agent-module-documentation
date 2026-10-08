# Configure the Chosen SHS widget

Enable `shs`, `chosen`, and `shs_chosen`. Like the parent module, shs_chosen has **no global
admin page** — it is configured per field on *Manage form display*.

## Enable the widget

On the field's **Manage form display**, choose the **Simple hierarchical select: Chosen** widget
(plugin id `options_shs_chosen`). The field requirements are the parent's: an `entity_reference`
to `taxonomy_term` targeting a **single vocabulary**. This widget renders exactly like SHS
(cascading level selects with AJAX child loading) but each `<select>` becomes a Chosen control
with a search box.

## Settings (`field.widget.settings.options_shs_chosen`)

Inherits the parent SHS keys (`force_deepest`, `create_new_items`, `create_new_levels`,
`display_node_count`) and adds:

| Key | Default | Meaning |
|---|---|---|
| `chosen_override` | `false` | Use the custom `chosen_settings` below for this field instead of the site-wide Chosen config. |
| `chosen_settings.disable_search` | `false` | Hide the Chosen search box. |
| `chosen_settings.search_contains` | `false` | Match the search term anywhere in a word, not just the start. |
| `chosen_settings.placeholder_text_multiple` | "Choose some options" | Placeholder for multi-value selects. |
| `chosen_settings.placeholder_text_single` | "Choose an option" | Placeholder for single selects. |
| `chosen_settings.no_results_text` | "No results match" | Message shown when a search matches nothing. |

The `chosen_settings` fieldset only applies when **`chosen_override` is checked**; otherwise the
widget uses the global `chosen.settings` config (admin route `chosen.admin`). At render time
`shs_chosen_shs_js_settings_alter()` merges the per-field overrides on top of `chosen.settings`
and passes them to the browser as `display.chosen` options (selector `select.shs-select`,
plus `minimum_width`, `disable_search_threshold`, etc. read from the Chosen config).

Set these in the field's form-display config (`core.entity_form_display.*`) via
`drush config:edit` or config import/export.

## Views

`shs_chosen_views_plugins_filter_alter()` swaps the SHS `taxonomy_index_tid` /
`taxonomy_index_tid_depth` filter classes to the Chosen-aware `ShsChosenTaxonomyIndexTid*`
variants, so an exposed hierarchical Views filter also gets Chosen styling.
