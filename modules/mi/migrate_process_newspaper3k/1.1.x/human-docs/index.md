# Migrate Process Newspaper3k — manual setup guide

**Migrate Process Newspaper3k** (`migrate_process_newspaper3k`) is a Migrate
*process plugin* that turns a web page URL into clean article content during a
migration. Behind the scenes it hands the URL to the Python
[Newspaper3k](https://newspaper.readthedocs.io/) article‑download framework
(Newspaper4k is also supported), which fetches the page, strips away the
navigation, ads, and other boilerplate, and returns the main article text plus a
pile of extracted metadata — title, summary, top image, all images, authors,
keywords, publish date, and more.

It solves the problem of importing readable article content from arbitrary news
or blog pages: instead of scraping HTML yourself, you point the plugin at a URL
and get a structured array of fields back, ready to map onto a node's body,
title, image, and taxonomy fields.

This module is a bridge to an external Python tool, so there is a real
prerequisite: your web server must have **Python 3** available with the
Newspaper3k (or Newspaper4k) library and its language corpora installed. The
plugin shells out to that Python process and **fetches the target URL
server‑side** — so treat the URLs you feed it as trusted, developer‑supplied
values in a migration, not visitor input, and be aware of the outbound network
(egress) that fetching remote pages implies. The module depends only on core
**Migrate** and adds no admin pages, so it is configured entirely from your
migration YAML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Python
   Newspaper3k/4k prerequisites (including a DDEV recipe).

There is **no configuration page** for this module — it has no settings form.
You use it from your migration definitions, as described below.

## How to use it

Chain the plugin in a migration `process` step. A typical pipeline resolves the
source link, runs Newspaper3k over it, skips the row on failure, and then
extracts the piece you want:

```yaml
process:
  'body/value':
    - plugin: migrate_process_js_redirect_link
      source: link
    - plugin: migrate_process_newspaper3k
    - plugin: skip_on_empty
      method: row
      message: 'migrate_process_newspaper3k import failed'
    - plugin: extract
      index:
        - summary
```

The plugin returns an array whose keys include `title`, `text`, `summary`,
`top_img`/`top_image`, `imgs`/`images`, `authors`, `keywords`, `publish_date`,
`html`, `article_html`, `meta_description`, and more. Use the core `extract`
plugin to pull out the specific key you need for each destination field.

> **Newspaper4k note:** the schemas differ slightly — for example the `text` key
> becomes `_text` under Newspaper4k. Check the bundled stub JSON if you switch
> libraries.
