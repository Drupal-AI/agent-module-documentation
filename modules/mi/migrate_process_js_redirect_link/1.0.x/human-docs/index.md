# Migrate Process JS Redirect Link — manual setup guide

**Migrate Process JS Redirect Link** (`migrate_process_js_redirect_link`) is a
Migrate process plugin that takes a link which points at a **JavaScript‑redirect
landing page** and returns the real target URL it redirects to. This is the exact
pattern Google uses in its RSS feeds: the feed gives you a `news.google.com`
link, that page contains a JS redirect to the actual article, and this plugin
resolves it to the real destination.

Getting the real URL has two benefits: your imported links go straight to the
source article (skipping Google's interstitial page and cookie‑consent form), and
your site shows up as the referrer instead of everything being funnelled through
Google. The plugin is registered as `migrate_process_js_redirect_link`, with an
alias `migrate_process_js_link` for use in existing pipelines.

It depends only on core **Migrate** (`migrate`) and supports **Drupal 8 through
11**. This is migration‑time tooling with no route or UI — it runs when a
developer executes the migration. There is no admin settings screen; you
configure it inline in your migration YAML.

> **Fetches URLs server‑side — trust your source.** The plugin issues an HTTP GET
> to the URL your migration feeds it. It only fetches values that pass validation
> as an absolute `http(s)` URL, and it returns an empty string for anything else
> (fetch failures are logged and also yield an empty string). Those URLs come
> from your migration source data, which you control — but keep the source
> trusted and run the migration only in environments where that holds. TLS
> certificate verification is left at its safe default (enabled). This module's
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

Add the plugin to the process step for the link field you want to resolve, with
`source` pointing at the field that holds the redirect URL:

```yaml
process:
  'field_web_link/uri':
    - plugin: migrate_process_js_redirect_link
      source: link
```

It is commonly chained with other plugins to do more with the resolved page — for
example `migrate_process_html`, `dom`, `dom_select`, `skip_on_empty`, and
`file_remote_url` to pull an image out of the target article:

```yaml
process:
  'body/value':
    - plugin: migrate_process_js_redirect_link
      source: link
    - plugin: migrate_process_html
      jsredirect: false
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

The `migrate_process_js_link` alias works anywhere the full plugin id does, which
is handy in pipelines that already reference the shorter name.
