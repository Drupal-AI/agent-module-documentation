<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `entity_field_lookup` — Migrate process plugin reference

Plugin id: **`entity_field_lookup`**. Annotation: `@MigrateProcessPlugin(id = "entity_field_lookup",
handle_multiples = FALSE)`. Class: `Drupal\entity_field_lookup\Plugin\migrate\process\EntityFieldLookup`.

Use it as a `process` step in a migration. Given the incoming `source` value, it runs an
`EntityQuery` and returns the **id of the first matching entity**, or `NULL`.

## Configuration keys

| Key | Required | Type | Default | Meaning |
| --- | --- | --- | --- | --- |
| `source` | yes | string | — | Standard Migrate input; the value compared against `entity_field`. |
| `entity_type_id` | **yes** | string | — | Entity type to query (e.g. `node`, `taxonomy_term`, `user`, `commerce_product`). Unknown type → `InvalidPluginDefinitionException`. |
| `bundle_key` | **yes** | string | — | The bundle field key (e.g. `type` for nodes, `vid` for terms). |
| `bundle_id` | **yes** | string \| list | — | Bundle machine name, or a list of them. Matched with the `IN` operator, so a scalar is auto-wrapped in an array. |
| `entity_field` | **yes** | string | — | The field queried against the source value (`condition(entity_field, $value)`, default `=` operator). |
| `access_check` | no | bool | `TRUE` | Whether the query applies entity access. `true` excludes entities the current context may not access (e.g. unpublished); `false` disables the check. |
| `extra_conditions` | no | list | — | Additional query conditions; see below. |

Missing any of the four required keys throws `BadPluginDefinitionException` when the plugin is
constructed (i.e. as the migration is prepared).

### `extra_conditions`

A list; each item becomes `->condition($field, $value, $operator, $langcode)`:

| Sub-key | Required | Notes |
| --- | --- | --- |
| `field` | **yes** | Empty/missing → `InvalidPluginDefinitionException`. |
| `value` | no | Defaults to `NULL`. |
| `operator` | no | Defaults to `NULL` (core then uses `=`, or `IN` for array values). |
| `langcode` | no | Defaults to `NULL`. |

## Return value

- Input value `NULL` → returns `NULL` (no query run).
- Query has results → returns `reset($results)` — the **first** entity id. There is **no explicit
  sort**, so with multiple matches the "first" is whatever the storage returns first; do not rely on
  it being deterministic. Query the field on a value that is unique in practice.
- No results → returns `NULL`. Combine with `skip_on_empty`, a default value, or a stub migration to
  define the miss behaviour.

## Minimal example

```yaml
process:
  field_author:
    plugin: entity_field_lookup
    source: author_email
    entity_type_id: user
    bundle_key: user
    bundle_id: user
    entity_field: mail
```

## Full example (from the plugin docblock)

```yaml
process:
  field_tags:
    plugin: entity_field_lookup
    source: source_key
    entity_type_id: node
    bundle_key: type
    bundle_id: article
    entity_field: field_name
    access_check: false
    extra_conditions:
      - field: field_number
        value: 3
        operator: '>='
        langcode: en
      - field: field_string
        value: 'something'
        operator: NULL
        langcode: NULL
```

## Multiple bundles + defined miss behaviour

```yaml
process:
  temp_term:
    plugin: entity_field_lookup
    source: category_label
    entity_type_id: taxonomy_term
    bundle_key: vid
    bundle_id: [tags, topics]     # matched with IN across both vocabularies
    entity_field: name
  field_category:
    plugin: skip_on_empty
    method: row                    # skip the whole row when no term matched
    source: '@temp_term'
```

## Operational notes

- Runs **one query per processed row** — frequently the slowest part of a large migration. Add a
  database index on `entity_field` (and any `extra_conditions` field) where possible.
- `handle_multiples = FALSE`: the plugin processes a single scalar value, not a multi-value array,
  per invocation.
- Keep `access_check` at its default (`TRUE`) unless the import is fully trusted and you specifically
  need to match entities that entity access would otherwise hide (e.g. unpublished nodes).
