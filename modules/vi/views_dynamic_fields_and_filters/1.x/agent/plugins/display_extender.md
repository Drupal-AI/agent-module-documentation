<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Dynamic fields and filters" display extender

## Install & enable

```bash
composer require drupal/views_dynamic_fields_and_filters
drush en views_dynamic_fields_and_filters -y
```

Only dependency is core **`views`**. `hook_install()` appends the extender id to the
`views.settings:display_extenders` list; `hook_uninstall()` removes it. No permissions of its own —
editing it needs the same core **administer views** permission as any Views edit.

## Where you configure it

The plugin (`DynamicFieldsAndFilters`, id **`views_dynamic_fields_and_filters`**, extends core
`DisplayExtenderPluginBase`, `no_ui = FALSE`) appears as a **Dynamic fields and filters** entry in
the *advanced* (third) column of each display in the Views UI. Settings are **per display**.
`buildOptionsForm()` renders three vertical tabs: **Parameters**, **Settings**, and a **Usuage**
[sic] tab that dumps the module's static `README.html` (via `file_get_contents`) for reference.

### Parameters tab

Nine text fields `dff1`–`dff9`. In each you enter a **request parameter name** as it appears in the
request:

- a query-string key, e.g. `type` for `example.com/my_view?type=foobar`;
- a POST parameter name;
- an exposed filter/sort **identifier** (from the filter's *filter identifier* / *sort field
  identifier*);
- a contextual filter, **only** when its "provide a default value type" is *Query parameter*.

`validateOptionsForm()` rejects any parameter name containing whitespace
(`preg_match('/\s/', ...)`).

### Settings tab

- **`case_insensitive`** — lowercases both sides (`mb_strtolower`) before comparing.
- **`add_query_cache_tags`** — when the display cache is enabled, adds the `url.query_args` cache
  context so query-driven output variations (esp. Serializer/RSS/JSON export) get separate cache
  entries. Applied by `extendCacheIfEnabled()`, which no-ops if cache type is `none`/defaults-off.
- **Copy from other display** — a select of other displays in the same view that already have dff
  config; choosing one and saving overwrites this display's `$this->options` from that display
  (`submitOptionsForm()`), instead of saving the entered values.

## Config storage & schema

Saved on the display under
`display_options.display_extenders.views_dynamic_fields_and_filters`:

```yaml
parameters:
  dff1: type
  dff2: mode
  # dff3 … dff9
settings:
  case_insensitive: 0
  add_query_cache_tags: 1
```

Schema: `config/schema/views_dynamic_fields_and_filters.views.schema.yml` defines
`views.display_extender.views_dynamic_fields_and_filters` with a `parameters` map (`dff1`–`dff9`
strings) and a `settings` map (`case_insensitive`, `add_query_cache_tags` booleans).
`hook_update_810001()` migrated the old `…views_dynamic_fields_and_filters.views_dynamic_fields_and_filters.*`
keys to `…parameters.*` and set `settings.add_query_cache_tags = 1` on existing displays.

## The condition DSL (in a field/filter *administrative title*)

Put the condition in the **Administrative title** of any field or filter:

```
dff{1..9}|expression|Your custom administrative title
```

- `isDffLabel()` treats a label as a condition only if it matches `^dff[1-9]\|` **and** has more
  than two `|`-separated parts. Any other label is left untouched (`testLabel()` returns `TRUE`).
- The custom title after the second `|` is optional but the trailing `|` after the expression is
  mandatory.

### Expression syntax (`evaluateCondition($value, $condition)`)

`$value` is the live request value for that `dffN` (`$view->getRequest()->get($name)` via
`getParametersWithValues()`). Plain text ⇒ loose `==` match. Brace expressions `{op:value}`:

| Expression | Meaning | Implementation |
|---|---|---|
| `{neq:v}` | not equals | `$value != v` |
| `{in:a,b,c}` | in set (comma, no spaces) | `in_array($value, explode(',', v))` |
| `{nin:a,b,c}` | not in set | `!in_array(...)` |
| `{gt:v}` | greater than | `$value > v` (both numeric → cast with `+`) |
| `{lt:v}` | less than | `$value < v` |
| `{cn:v}` | contains | `strpos($value, v) !== FALSE` |
| `{ncn:v}` | not contains | `strpos($value, v) === FALSE` |

Notes: unrecognized operators fall back to a plain `==` compare. If the request value is an
**array** (`?types[]=foo&types[]=bar`) the condition is true if **any** element matches (recursive
call). Always use the url-decoded value in the expression. With `case_insensitive` on, both sides
are `mb_strtolower`ed first.

### Chaining (`testLabel()`)

```
dff{1..9}|expr|OPERATOR|dff{1..9}|expr|OPERATOR|dff{1..9}|expr|Title
```

`OPERATOR` is `AND`, `OR` or `XOR` (uppercase), each followed by a `dff[1-9]|expr` pair; up to ~10
combinations (loop `$i = 2..32`). The first condition's result is folded left-to-right with each
combination using PHP `&&` / `||` / `xor`. A referenced `dffN` not present in the parameter map
evaluates that clause to `FALSE`.

Example: `dff2|{gt:5}|AND|dff4|{in:foo,bar}|OR|dff3|foobar|` →
`(dff2 > 5 AND dff4 ∈ {foo,bar}) OR dff3 == 'foobar'`.

## How it is applied at runtime

`views_dynamic_fields_and_filters_views_pre_build(ViewExecutable $view)` (the `.module` file) is the
only execution path:

1. Reads the display's extenders; returns early if this extender is absent or has `< 1` parameters.
2. Calls `extendCacheIfEnabled()`.
3. For each `$view->field`: if `testLabel($field->options['admin_label'])` is false, sets
   `options['exclude'] = TRUE` (field is built but excluded from output).
4. For each `$view->filter`: if `testLabel($filter->options['admin_label'])` is false,
   `unset()`s the filter (it is not applied to the query).

Because this runs in `pre_build`, dropped filters never reach the query and excluded fields never
render. It works for any display type and any format that uses the display's fields/filters (page,
block, REST/JSON export, RSS/Serializer). It only removes/hides items already defined on the view;
it never introduces new fields or filters.

## Operating notes

- Field/entity **access** is still enforced by core independently — hiding a field here is a display
  change, not an access grant, and the module never surfaces fields the view didn't already define.
- Removing a restricting filter naturally **broadens** the result set; that is the intended,
  admin-authored behavior — design the conditions so the broadened set is acceptable for the
  audience that can reach the URL.
- For cached non-HTML formats (Serializer/RSS), enable **`add_query_cache_tags`** or query-varied
  responses may be served from a stale cache entry.
- Compatible/tested with the *Views Conditional* contrib module and core *REST export* +
  *Serialization*.
