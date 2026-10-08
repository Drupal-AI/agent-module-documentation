# Migrate Source GraphQL — manual setup guide

**Migrate Source GraphQL** (`migrate_source_graphql`) adds a Migrate *source
plugin* that reads its rows from a **GraphQL endpoint**. Just as Migrate Source
CSV lets you migrate from a CSV file, this plugin lets you write a migration YAML
that defines a GraphQL endpoint and a query, and pulls the content that query
returns into Drupal.

Migrate's built‑in sources cover databases, CSV, XML, JSON, and Drupal itself —
which reflects where content used to come from. Increasingly it comes from an API,
and a growing share of those are GraphQL: a headless CMS like Contentful or
Sanity, another Drupal exposing the `graphql` module, a commerce platform, or an
internal service. You *could* read those with the JSON source plugin, but you'd
lose what GraphQL is for — the query declares exactly which fields you want, so
the response is shaped for the migration rather than filtered afterwards, and
nested relationships come back in a single request instead of one per row.

The plugin supports authenticated endpoints (`auth_scheme` plus `auth_parameter`
build the `Authorization` header, so Basic, Bearer, Digest, and similar schemes
all work), custom data keys, custom ID fields, query arguments for
filtering/pagination, and a results event other modules can subscribe to in order
to modify the data mid‑migration. It depends only on core **Migrate** and has no
admin UI — you configure it from your migration YAML.

Because it fetches from a remote system over the network, keep three things in
mind: your server needs outbound egress to the endpoint; the endpoint is
**external and can change under you**, so a rerunnable migration wants its query
pinned and its responses validated (a field disappearing upstream turns into empty
content downstream rather than an error); and if the API is paginated, get the
pagination handling right — a migration that doesn't follow the API's paging can
silently import only the first page and still report success.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form.
You use it from your migration definitions, as described below.

## How to use it

The `graphql` source plugin takes the endpoint, optional authentication, and a
query definition. In outline:

```yaml
source:
  plugin: graphql
  # [mandatory] The GraphQL endpoint URL.
  endpoint: 'https://example.com/api'
  # [optional] Auth scheme (Basic, Bearer, Digest, …) and its parameter — together
  # these build the Authorization header.
  auth_scheme: Bearer
  auth_parameter: 'YOUR_TOKEN'
  # [optional] A custom name for the "data" property.
  data_key:
  # [mandatory] The query definition.
  query:
    # the query name, its optional arguments, and its fields
```

A complete example, migrating "posts" from the public GraphQLZero test API into
Drupal articles:

```yaml
id: migrate_graphql_posts_articles
label: 'Migrate posts from GraphQLZero'
source:
  plugin: graphql
  endpoint: 'https://graphqlzero.almansi.me/api'
  auth_scheme: Bearer
  auth_parameter: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
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
migration_dependencies: {  }
```

The `fields` property is mandatory in the YAML transposition of the query, and the
top‑level results key is `data` unless you override it with `data_key`. Query
`arguments` let you add filtering and pagination. Run the migration with
`drush migrate:import` as usual.

> **Keep secrets out of committed YAML.** The `auth_parameter` above is a token —
> in a real project, store it in an environment variable (and, ideally, a Key
> entity) rather than pasting the raw value into a file you commit.
