<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the entityreference filter on a View

No global admin page (`configure` is `null`). All configuration lives on the filter handler
in a View. There are **two views involved**:

1. **The reference view** — supplies the options. It MUST have a display of type
   **Entity Reference** (the display plugin core Entity Reference module provides), and its
   **base entity type must match** the field being filtered (a `node` view for a nid field,
   `user` for uid, `taxonomy_term` for a term-reference field, etc.). Only such displays are
   offered; if none exist the filter shows "No views to use."
2. **The filtered view** — where you add the exposed filter.

## Add the filter

In the filtered view's *Add filter criteria* list, pick the entry named
**"{Field} (entityreference filter)"** (e.g. "Has taxonomy terms (entityreference filter)",
"Content: ID (entityreference filter)"). These extra handlers are generated for every
entity-id column and `*_target_id` reference field. Expose it to show the dropdown.

## Filter option keys (config schema `views.filter.entityreference_filter_view_result`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `reference_display` | string | `''` | The reference view display, `"view_name:display_id"`. Required. Only Entity-Reference displays whose base table matches the filtered field are listed. |
| `reference_arguments` | string | `''` | Contextual arguments passed to the reference view, `arg1/arg2/…` (see tokens below). Optional. |
| `type` | string | `select` | Widget: `select` (dropdown). `textfield` (autocomplete) is declared but disabled — a `@todo`. |
| `hide_empty_filter` | boolean | `TRUE` | Hide the exposed widget entirely when the reference view returns no options (set in the *Expose* section). |
| `value` | sequence | — | Selected value(s); managed at runtime, recalculated from the current option list. |

The filter extends core `ManyToOne`, so it also carries the standard `operator`
(`in` / `not in` / `empty` / `not empty`) and `expose` settings.

## `reference_arguments` tokens

Passed to the reference view as contextual filter values, in order, `/`-separated:

- `!n` — argument *n* of the filtered view's dynamic URL argument (`%`).
- `#n` — argument *n* of the filtered view's contextual filter value.
- `[filter_identifier]` — the live value of another **exposed filter** on the same view
  (its *Filter identifier*). This is what makes filters **dependent**.
- any other string — passed literally.

By default (empty), the reference view receives the same arguments as the filtered view.

## Dependent / cascading exposed filters (AJAX)

Put another exposed filter's identifier in `reference_arguments`, e.g. `[country]`. Now this
filter's options are recomputed whenever the `country` filter changes: the module attaches
its JS library and, on change, POSTs to route `entityreference_filter.ajax`
(`/entityreference_filter/ajax`) to rebuild the option list without a full page reload. A
value that is no longer valid after the parent changes is dropped. **Circular** dependencies
between filters are detected at save time and rejected with a validation error naming the
cycle. (With Better Exposed Filters "auto-submit" on, the standard exposed-form AJAX is used
instead of this module's cascade.)

## Non-exposed use = subquery IN / NOT IN

If you do **not** expose the filter, it becomes a static `IN` / `NOT IN` subquery: the
reference view is the inner query and its result-set entity ids are injected into the outer
query's condition — a feature core Views lacks. If the reference view returns nothing, a
sentinel `0` is used so the condition matches no rows.

## Notes

- The reference view is the single source of truth for both the option **set and order**;
  to reorder the dropdown, sort the reference view. (BEF option-rewrite labels are kept but
  re-ordered back to the view order on render.)
- Options respect the reference view's access checks; filter cache tags follow the referenced
  entity type(s), and a `user.permissions` cache context is added.
- Better Exposed Filters (`suggest`) can rewrite the option labels.
