<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views handler: "Parent ID From Term"

The whole module is two procedural Views hooks. There are no classes, no `src/`, no config, no
schema, no permissions, and no dependencies beyond core `views` + `taxonomy`.

## Install / enable

`drush en views_taxonomy_parent_id_from_term -y`. Enable/disable is the only lifecycle: while
enabled the query rewrite (below) runs; disabled, the Views handler is gone and any View that used
it filters on the raw term id instead of the parent id.

## 1. Registered Views data — `hook_views_data_alter()`

File: `views_taxonomy_parent_id_from_term.views.inc`.

Adds one item, `$data['taxonomy_term__parent']['term_parent']`:

- `title` = *"Parent ID From Term"*, `help` warns it "can produce duplicate entries if you are
  using a vocabulary that allows multiple parents."
- `real field` = `parent_target_id` (the column on the `taxonomy_term__parent` field table).
- `relationship` → base `taxonomy_term_field_data`, field `parent_target_id`, id `standard`,
  label *"Parent ID From Term"*.
- `filter` → id `numeric` (core's numeric filter handler).
- `argument` → id `taxonomy` (core's taxonomy argument / contextual-filter handler).

So in the Views UI, on a View of **Taxonomy terms**, you can add "Parent ID From Term" as a
relationship, as a filter, or (most usefully) as a **contextual filter / argument**.

## 2. Query value rewrite — `hook_views_query_alter()`

File: `views_taxonomy_parent_id_from_term.views_execution.inc` (signature
`(ViewExecutable $view, $query)`).

At query build time it iterates `$query->where` → each `$condition_group['conditions']` → each
`$condition`, and acts only when `substr_count($condition['field'], ':taxonomy_term__parent_term_parent')`
is truthy (i.e. this handler's placeholder is present). For a matching condition it:

1. Loads `entity_type.manager` → `taxonomy_term` storage.
2. `$parents = $storage->loadParents($condition['value'][':taxonomy_term__parent_term_parent'])`
   — resolves the **input term id** to its parent term entities.
3. `reset($parents); $first_key = key($parents);` — takes the **first** parent only.
4. Sets `$parent_id` to that first parent's `->id()`, or `NULL` when there is no parent.
5. Writes `$parent_id` back into `$condition['value'][':taxonomy_term__parent_term_parent']`.

Net effect: whatever term id you feed the filter/argument is transparently replaced by that term's
parent id before the SQL condition executes — the same field/operator, just a substituted value.

## Behavioural notes

- **Top-level term** → `loadParents()` returns empty → value becomes `NULL` → the numeric
  condition matches nothing, so the View is empty. Plan a fallback for the no-argument / no-parent
  case.
- **Multiple parents** → only `key($parents)` (first) is used; multi-parent vocabularies can yield
  duplicate rows, as the registered help text states. The module explicitly does not support
  choosing among multiple parents.
- The rewrite keys entirely off the literal placeholder name `:taxonomy_term__parent_term_parent`;
  it does not depend on any config, so no settings exist to tune.

## No security surface

`loadParents()` takes the term id through the entity storage API (parameterized), the value comes
from a Views handler configured by a site builder, there are no routes, no external HTTP, no
user-rendered markup, and no raw SQL. Operate it as an ordinary Views enhancement.
