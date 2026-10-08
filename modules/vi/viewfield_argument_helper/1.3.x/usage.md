<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Viewfield Argument Helper augments the Viewfield editing widget so a content editor composing a view's contextual-argument string can look up the actual entity ids, labels and bundles that each contextual filter accepts, instead of hunting for raw numeric ids in another tab.

---

Viewfield lets an editor drop a view display into a node's field and, per the view's contextual filters, supply an argument string such as `204,95/72` — terms 204 OR 95 for the first argument, node 72 for the second. Composing that string is opaque: nothing in the interface says how many contextual filters the display has, what entity type each one takes, or what the valid ids are, and a wrong id fails silently (the view just returns nothing). This module does not change how Viewfield stores or renders the argument — it stays a plain text field — but it attaches an assistance UI beside it. On the `viewfield_select` widget it adds a "Filtering options" fieldset of per-argument **slots** and, driven by a per-field third-party widget setting (or a site default at `/admin/config/vah/settings`), one of two helper modes: **Lookup (legacy)**, which renders a filterable table of candidate entities (id / label / bundle) per slot, or **Autocomplete**, which turns each slot into a Choices.js-backed autocomplete. Both are fed by the `viewfield_argument_helper.lookup` service, which loads the view, inspects its argument (contextual-filter) handler plugins, guesses the target entity type — `taxonomy_index_tid`→taxonomy_term, `node_nid`→node, an entity-reference/list field read from the field definition — narrows to the bundles allowed by the argument's validator settings intersected with the field's `target_bundles`, then loads the matching entities and maps them to id/label/bundle. Three JSON routes back the widget (`/viewfield_argument_helper/lookup|autocomplete|slotinfo/...`), all gated by the `use viewfield argument helper` permission, and five alter hooks (`hook_viewfield_argument_helper_entity_type_alter`, `_bundles_alter`, `_entities_alter`, `_options_alter`, `_lookup_element_alter`) let other modules override the guessed entity type, bundles, entity list, and rendered markup. Note the helper is purely an authoring aid: the editor still hand-composes the final `,`/`+`/`/` argument string, and the module does not auto-inject the host entity's own id into the view.

---

- Help a content editor pick the right term id for a Viewfield contextual filter without leaving the edit form.
- Show, per view display, how many contextual arguments (slots) exist and what each one expects.
- Render a filterable lookup table of candidate taxonomy terms (id, label, vocabulary) for a `taxonomy_index_tid` argument.
- Render a lookup table of candidate nodes for a `node_nid` contextual filter.
- Offer a Choices.js autocomplete per argument slot instead of a raw numeric field.
- Set a site-wide default helper mode (Lookup vs Autocomplete) at `/admin/config/vah/settings`.
- Override the helper mode per Viewfield field via the widget's third-party settings on a form display.
- Constrain the candidate list to the bundles the view's argument validator allows (e.g. one vocabulary).
- Further constrain candidates to the entity-reference field's own `target_bundles` when the argument reads a reference field.
- Surface allowed-values options for a `string_list_field` contextual argument.
- Reduce "the embedded view shows nothing" support tickets caused by mistyped ids.
- Give editors the id/label mapping for entities even when the view's own UI does not expose them.
- Let a module alter the guessed entity type for a specific view/display via `hook_viewfield_argument_helper_entity_type_alter`.
- Let a module drop or add allowed bundles for a slot via `hook_viewfield_argument_helper_bundles_alter`.
- Replace the candidate entity list entirely (e.g. one specific vocabulary) via `hook_viewfield_argument_helper_entities_alter`.
- Rewrite a slot's title/description in the lookup UI via `hook_viewfield_argument_helper_lookup_element_alter`.
- Customise the autocomplete option list via `hook_viewfield_argument_helper_autocomplete_options_alter`.
- Gate who can use the assistance UI (and thus enumerate candidate ids/labels) with the `use viewfield argument helper` permission.
- Support building a related-content or events listing embedded in a landing-page node.
- Speed up editorial setup of product-grid or category-filtered view embeds.
- Provide a JSON slot-info endpoint (`/viewfield_argument_helper/slotinfo/{view}/{display}`) for custom front-end tooling around Viewfield.
