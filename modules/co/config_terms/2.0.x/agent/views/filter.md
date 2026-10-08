# Views integration (`config_terms_views` submodule)

Enable the `config_terms_views` submodule (depends on `config_terms` + core `views`) to filter Views
by a config-term reference. It ships one Views filter plugin and rewires reference fields to use it.

## Filter plugin

`Drupal\config_terms_views\Plugin\views\filter\ConfigTermsIndex` (`@ViewsFilter("config_terms_index")`),
extending core `ManyToOne`. Schema: `views.filter.config_terms_index` (extends `views.filter.many_to_one`).

Extra options (`buildExtraOptionsForm` / schema):

| Option | Type | Meaning |
|---|---|---|
| `vid` | string | Which config vocabulary to draw terms from |
| `type` | string | `select` (dropdown) or `textfield` (autocomplete) |
| `hierarchy` | boolean | Show depth-indented hierarchy in the dropdown |
| `limit` | boolean | Limit the filter to the chosen vocabulary (default true) |
| `error_message` | boolean | Show the "invalid vocabulary" message |
| `value` | sequence of string | Selected term IDs |

Behavior: builds its options from `TermStorage::loadTree()`; the autocomplete mode uses an
`entity_autocomplete` element with `#target_type = config_terms_term` and
`#selection_settings['target_vocabs']`. `getCacheContexts()` adds `user` (results depend on term
access). `calculateDependencies()` adds the vocabulary and selected terms as config dependencies.

## How the filter gets attached

`config_terms_views.views.inc` implements `hook_field_views_data_alter()`: for any
`entity_reference` field storage whose `target_type` is `config_terms_term`, it rewrites each
non-`delta` filter's `id` to `config_terms_index`. So once the submodule is on, an
entity_reference-to-config_terms_term field automatically exposes this filter in Views.
