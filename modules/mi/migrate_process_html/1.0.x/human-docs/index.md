# Migrate Process HTML — manual setup guide

**Migrate Process HTML** (`migrate_process_html`) is a Migrate process plugin that
**fetches a URL and returns the page's HTML as a string** during a migration. It
is designed for pipelines that start from a link field — for example the item
links in an RSS feed — where you want to pull the remote page's markup into a row
so later steps can extract something from it (an `og:image`, a body, and so on).

Because RSS feeds served by Google often hide the real article behind a JavaScript
redirect page, the plugin can follow that redirect by default. You can turn that
behaviour off from your migration config by setting `jsredirect: false`, which is
useful when you have already resolved the target link with a companion plugin such
as `migrate_process_js_redirect_link`.

It depends only on core **Migrate** (`migrate`) and supports **Drupal 8 through
11**. This is migration‑time tooling that runs in the admin/CLI context, not in
response to a site‑visitor request. It has no admin settings screen — you
configure it inline in your migration YAML.

> **Fetches URLs server‑side — trust your source.** The plugin retrieves whatever
> URL your migration feeds it, from the server. Make sure the source URLs are
> trusted (they come from your migration source data, which you control), and run
> the migration only in environments where that is the case. The remote HTML you
> fetch is untrusted third‑party markup: when you store any of it into a Drupal
> field, store it against an appropriate **text format** so it is subject to that
> format's XSS filtering on output, rather than outputting it raw. This module's
> releases are **not covered** by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core Migrate.

There is **no configuration page** for this module. It has no settings form; you
use the plugin from migration YAML as described below.

## How to use it

Add `migrate_process_html` as a process step for the field you are building,
usually chained with other plugins that then parse the fetched HTML. A typical
pipeline pulls a page and extracts its `og:image`:

```yaml
process:
  'body/value':
    - plugin: migrate_process_js_redirect_link
      source: link
    - plugin: migrate_process_html
      jsredirect: false      # optional: disable the built-in JS-redirect follow
    - plugin: dom
      method: import
    - plugin: dom_select
      selector: '//meta[@property="og:image"]/@content'
    - plugin: skip_on_empty
      method: row
      message: 'Field image is missing'
    - plugin: extract
      index:
        - 0
    - plugin: file_remote_url
```

Point the first step's `source` at the field holding the URL. Note that using
`skip_on_condition` with a `matches` condition (as some examples do) requires the
separate **Migrate Conditions** module (`drupal/migrate_conditions`).
