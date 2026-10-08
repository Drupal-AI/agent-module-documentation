<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the Views data & query are generated

All the interesting logic is in `config_views.views.inc` (`hook_views_data()` +
`_views_views_config_process_schema()`), plus the query plugin.

## `config_views_views_data()`

Iterates every entity type. For each config entity type (implements
`ConfigEntityInterface`):

- If it has a **list builder**, registers a Views **area** handler `entity_<type>`
  ("Rendered entity - <label>") so a rendered config entity can be placed in a header/footer.
- If it has a **config prefix**, registers a base table `config_<prefix with . → _>` whose
  `base` uses `query_id => 'views_config_entity_query'` and `field => <id key>`. It also adds
  an `operation` field (`config_entity_operations`).
- Then finds the type's schema definition (the `*` key under its prefix, e.g. `node.type.*`)
  and recurses through it with `_views_views_config_process_schema()` to expose typed
  properties as Views fields.

## `_views_views_config_process_schema()`

Recursively walks a config schema definition (following `type` references, `mapping`, and
`sequence`) and, for each primitive labelled leaf, calls `_views_views_config_data_add()`,
which maps the schema type to Views handlers:

| Schema type | field id | filter id | argument id |
|---|---|---|---|
| `boolean` | `boolean` | `config_entity_boolean` | `standard` |
| `integer` | `numeric` | `numeric` | `numeric` |
| other (string, etc.) | `standard` | `config_entity_string` | `standard` |

Because it only follows schema, the set of exposed columns depends on how richly each config
entity type is described in its `config/schema`.

## The query plugin — `views_config_entity_query`

`src/Plugin/views/query/ConfigEntityQuery.php` extends the core `Sql` views query plugin but
executes the **Entity Query API** against the config entity storage instead of running SQL.
It translates Views conditions/sorts into entity-query conditions. This is why filtering and
sorting on these base tables works even though config entities have no SQL table of content
rows.

## Note: two hook_views_data implementations

The file also contains `config_views_views_data_sample()` (a generic `config_views` base with
`config_entity_id`/`label`/`type`/`description` fields and the `config_entity` wizard). The
per-type tables above are the ones you normally build Views on.
