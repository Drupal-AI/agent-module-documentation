# Migration JsonAPI — manual setup guide

**Migration JsonAPI** (`migration_jsonapi`) extends
[Migrate Plus](https://www.drupal.org/project/migrate_plus)'s JSON data parser so
that a migration can pull content straight from a remote Drupal site's
**JSON:API** — and, crucially, generate and paginate all the request URLs for you
automatically.

The problem it solves is pagination. Drupal's JSON:API returns results in limited
batches, so fetching a whole collection means making many requests, each with a
different page offset. Migrate Plus's stock JSON parser expects you to hand it a
fixed array of URLs — but you rarely know in advance how many pages there will be.
This module's `jsonapi` parser instead takes the pieces of the URL (host, prefix,
endpoint, query parameters) and builds every request it needs, walking the
collection by incrementing `page[offset]` until it hits an empty page. It also
supports multilingual sources: give it a list of langcodes and it iterates each
language, prepending the langcode to the path.

It is a pure developer/CLI migration tool — no routes, permissions, or admin UI.
You configure each import in migration YAML and run it with Drush (Migrate Tools
is handy here). It depends on Drupal core's **Migrate** module and on **Migrate
Plus**, and requires **PHP 8.1+**. The generated requests reach the remote host
over HTTP using Migrate Plus's HTTP data fetcher with standard TLS; each queried
URL is logged to the `jsonapi` logger channel so you can trace what it fetched.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (along with Migrate Plus).

There is **no configuration page** for this module — it has no settings form. Each
import is configured inside your migration YAML, described below.

## Where it lives in the admin menu

Migration JsonAPI adds no admin page or block. Its whole surface is the `jsonapi`
data parser, which you reference from a migration definition and run with Drush.

## How to use it

In your migration's `source`, use Migrate Plus's `url` plugin with
`data_parser_plugin: jsonapi`, and supply the pieces of the JSON:API URL. Note the
`urls: []` line — the URLs are generated at runtime, so you leave the list empty:

```yaml
source:
  plugin: url
  data_fetcher_plugin: http
  data_parser_plugin: jsonapi
  item_selector: data
  jsonapi_host: 'https://source.example.com'
  jsonapi_prefix: '/jsonapi'
  jsonapi_endpoint: '/node/article'
  jsonapi_query_params:
    filter:
      default_langcode: 1
  urls: []
```

`jsonapi_host`, `jsonapi_prefix`, and `jsonapi_endpoint` are required. The default
page size is 50 (`page[limit]`), and `page[offset]` is incremented automatically
until an empty page is returned.

**Multilingual imports** — list the langcodes you want and the parser iterates
each one:

```yaml
  jsonapi_query_params:
    filter:
      default_langcode: 0
  jsonapi_langcodes:
    - ja
    - de
  urls: []
```

If your source endpoint uses different parameter names, override them with
`jsonapi_query_param_keys` (for `page_offset`, `page_limit`, and `language`).
Run the migration with `drush migrate:import`, and combine it with Migrate Plus
process plugins to map the JSON:API fields onto your destination.
