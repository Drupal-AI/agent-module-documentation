# Migrate Destination Cache — manual setup guide

**Migrate Destination Cache** (`migrate_destination_cache`) provides a Migrate
**destination plugin**, `cache`, that writes migrated rows into a **Drupal cache
bin** instead of creating entities. It's a developer tool for situations where you
want to fetch and shape remote data on a schedule and stash the result in cache —
for example staging API responses so the rest of your site can read them quickly —
rather than persisting them as content.

The problem it solves is bridging Migrate (great at fetching, mapping and
transforming data) with Drupal's cache API (great at fast, expiring, tag‑based
storage). You build a normal migration, transform each row into a cache
`id`/`data` pair, and the plugin stores it — with optional expiry and cache tags.

There is **no settings form** — the plugin is configured in your migration YAML.
It depends only on core's **Migrate** module and runs on **Drupal 9, 10, and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you configure the plugin in
your migration YAML, as shown below.

## How to use it

Set the migration's destination to `cache` and map an `id`, a `data` payload, and
optionally `expire` and `tags`:

```yaml
process:
  id: id
  data:
    plugin: array_template
    template:
      foo: 'source:foo'
      bee: 'source:bee'
  expire:
    plugin: default_value
    default_value: 7600
  tags:
    plugin: default_value
    default_value:
      - tag1
      - tag2
destination:
  plugin: cache
  cache_bin: default
  default_expire: -1
  invalidate_tags: false
```

The destination options include `cache_bin` (which cache bin to write to),
`default_expire`, and `invalidate_tags`. The plugin pairs well with a
`url` source using the `dynamic_http` data fetcher when you need to pull
token‑templated URLs on each run — see the project examples for that pattern.
