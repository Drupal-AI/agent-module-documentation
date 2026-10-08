<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the query and name matching work

There is no public service API to call — the module's logic lives inside the Views argument
handler `IndexNameDepth::query()` and `::title()`. This doc explains the behaviour so an
agent can predict results and debug them.

## Name → term id resolution

The URL argument is a term **name**, resolved to term ids like this:

- With **Pathauto** enabled (the module's required dependency): every term in scope is
  loaded from `taxonomy_term_field_data`, and both the incoming argument and each term's
  `name` are passed through `pathauto.alias_cleaner`'s `cleanString()`. Terms whose cleaned
  name equals the cleaned argument are matched. This makes matching case- and
  separator-insensitive (e.g. `new-products` matches "New Products").
- Without Pathauto (defensive fallback): the argument's `-` are turned into spaces and an
  exact `t.name = :arg` match is used.
- If `vocabularies` is set, the term lookup is constrained with `t.vid IN (...)`.

## Depth traversal

The resolved term ids feed a subquery over `taxonomy_index` (`tn.nid`) whose node ids are
matched with `IN` against the main node table's real field (`nid`). Depth walks
`taxonomy_term__parent`:

- `depth = 0` — match only nodes tagged with the resolved term(s).
- `depth > 0` — left-join `taxonomy_term__parent` N times downward, OR-matching descendant
  terms so children are included (filter "Fruit" depth 1 also returns "Apple" nodes).
- `depth < 0` — join upward N times so ancestors are included.

## Multiple values (`break_phrase`)

When enabled, `a+b+c` is split; more than one value uses `IN` (OR semantics) — the code
notes AND is treated as OR here due to the number of joins required.

## Title callback

`IndexNameDepth::title()` resolves the argument back to a term (again via the Pathauto
alias cleaner, then a `name`-based `loadByProperties` fallback) so the view's title/breadcrumb
shows the human term name.

## Services used (via `create()`)

| Service | Use |
|---|---|
| `entity_type.manager` → `taxonomy_term` storage | load terms for the title |
| `database` | build the name lookup + node subquery |
| `module_handler` | detect whether `pathauto` is enabled |
| `pathauto.alias_cleaner` (`AliasCleanerInterface`) | normalise names for matching |

Config schema for the argument lives at
`config/schema/views_taxonomy_term_name_depth.views.schema.yml`
(`views.argument.taxonomy_index_name_depth`: `depth`, `break_phrase`,
`use_taxonomy_term_path`, `vocabularies`).
