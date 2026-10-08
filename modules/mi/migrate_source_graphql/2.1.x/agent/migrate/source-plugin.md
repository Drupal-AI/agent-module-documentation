<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `graphql` migrate source plugin

Class: `Drupal\migrate_source_graphql\Plugin\migrate\source\GraphQL`
(`@MigrateSource(id = "graphql", source_module = "migrate_source_graphql")`), extends
`SourcePluginBase`, implements `ConfigurableInterface` and `ContainerFactoryPluginInterface`.

## Minimal migration

```yaml
id: migrate_graphql_posts_articles
label: 'Migrate posts from GraphQLZero'
source:
  plugin: graphql
  endpoint: 'https://graphqlzero.almansi.me/api'
  query:
    posts:
      fields:
        - data:
            - id
            - title
            - body
  ids:
    id:
      type: string
process:
  title: title
  body: body
destination:
  plugin: 'entity:node'
  default_bundle: article
```

## Configuration keys

| Key | Required | Default | Meaning |
|-----|----------|---------|---------|
| `endpoint` | yes | `localhost` (default cfg, but empty throws) | GraphQL API URL. Empty ⇒ `\InvalidArgumentException`. |
| `query` | yes | — | Nested query definition (see below). Empty ⇒ `\InvalidArgumentException`. |
| `auth_scheme` | no | — | Authorization scheme word, e.g. `Bearer`, `Basic`, `Digest`. |
| `auth_parameters` | no | `''` | Credential/token. Header becomes `auth_scheme + ' ' + auth_parameters`. **Plural key.** |
| `data_key` | no | `data` | Property path to the row array in the response. `/`-separated; `%` = index map. |
| `ids` | no | `{id: {type: string}}` | Source unique key field(s) and types (`getIds()`). |

### The `query` structure

```yaml
query:
  <queryName>:              # top-level GraphQL query field, e.g. "posts"
    arguments:              # optional — becomes GraphQL args on <queryName>
      options:
        paginate: { page: 1, limit: 10 }
    fields:                 # required
      - <dataKey>:          # usually "data"; must match data_key's leaf
          - id
          - title
          - nested:         # nested selection sets are supported
              - childField
```

`GraphQL/Client::buildQueryRecursive()` turns this array into a `GraphQL\Query`.
`buildQuery()` renders `arguments` by JSON-encoding non-string values and stripping quotes from object
keys (`preg_replace('/"([a-zA-Z]+[a-zA-Z0-9_]*)":/', '$1:', ...)`) so they become GraphQL-style
`key: value` argument objects, wrapped in `GraphQL\RawObject`.

### Response navigation (`data_key`)

After the request, the plugin takes `results.getData().<queryName>` and then walks `data_key`:

- `data_key: data` (default) ⇒ `response.<queryName>.data`.
- `data_key: anotherBrickInTheWall` ⇒ `response.<queryName>.anotherBrickInTheWall`.
- Segments split on `/` (Drupal `Row::PROPERTY_SEPARATOR`), so `data_key: data/items` descends two levels.
- A `%` segment maps over an indexed array and extracts the **next** named field from each element.
  Example from the test suite: `data_key: data/%/user` against a `data` array of `{ user: {...} }`
  objects yields the list of `user` objects as rows.

Each surviving element is `json_decode(json_encode($element), TRUE)` (stdClass ⇒ nested assoc array)
and `yield`ed as a source row, so `process:` mappings reference the query's leaf field names directly.

## Authentication

If `auth_scheme` is set and non-empty, the plugin sends a single header:
`Authorization: <auth_scheme> <auth_parameters>`. There is no other auth mechanism. The value lives in
the migration's `source:` config, so treat it like any exportable secret (see transport notes).

## The `ResultsEvent`

Before yielding, the plugin dispatches `Drupal\migrate_source_graphql\Event\ResultsEvent`
(`extends \Drupal\migrate\Event\EventBase`). A subscriber can call `getResults()` / `setResults()` to
filter, reshape, sort, or replace the array of result objects. This is the supported extension point
for anything the query itself cannot express (client-side filtering, enrichment, splitting).

## Behavioural limits (important)

- **One request per run.** `getGenerator()` runs the query once. There is no cursor loop, no automatic
  page-walking. If the API paginates, you fetch only the page your `arguments` request. To import more,
  encode paging in `arguments` and/or run the migration multiple times with different args.
- **Errors are soft.** A `GraphQL\Exception\QueryError` is caught and surfaced via
  `\Drupal::messenger()->addError()`; the generator then yields nothing rather than throwing. A failed
  query can therefore look like an empty (successful) source unless you read the messages.
- **No response-shape validation.** Missing paths resolve to `[]` (empty), so an upstream field/shape
  change degrades to empty rows, not an error.
- **Transport.** Requests go through `gmostafa/php-graphql-client` → Guzzle with default options; TLS
  certificate verification is on and is not disabled by this module.
