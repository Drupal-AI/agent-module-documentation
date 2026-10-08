# Migrate Source Scraper — manual setup guide

**Migrate Source Scraper** (`migrate_source_scraper`) adds a new Migrate API
source plugin, `php_scraper`, that fetches remote web pages and turns them into
migration rows. Instead of feeding your migration a CSV, a database, or a JSON
feed, you give it a list of URLs and a set of XPath or CSS-selector rules — and
for each page it visits, the plugin extracts the fields you asked for and hands
them to the rest of your migration pipeline.

Under the hood it uses Symfony's BrowserKit and DomCrawler to load each page and
run your selectors against the returned HTML. It's the tool you reach for when
you need to seed Drupal content from a legacy static site, a supplier's product
pages, or any third-party site you are authorised to scrape. Because everything
is expressed in a migration YAML file and run from the command line, the imports
are repeatable, roll-back-able, and kept under version control alongside the rest
of your migration code.

There is nothing to click and nothing to configure in the admin UI — the module
works the moment you enable it, and you drive it entirely from migration
definitions and Drush. It depends only on Drupal core's **Migrate** module.

A note on where the pages come from: the scrape URLs live exclusively in the
migration definition that a developer writes, and the plugin only runs during
`drush migrate:import`. There is no route, form, or web-facing input, so the
fetch target is never attacker-controllable. Even so, remember that this module
makes your server perform outbound HTTP requests to whatever URLs you list — only
scrape sites you own or are permitted to scrape, and be mindful that the requests
originate from inside your hosting network.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
configure each scrape entirely inside your migration YAML, described below.

## Where it lives in the admin menu

Migrate Source Scraper adds no admin page, no block, and no permission. Its whole
surface is the `php_scraper` source plugin, which you reference from a migration
definition and run with Drush.

## How to use it

You use the plugin by setting `plugin: php_scraper` as the `source` of a
migration in a YAML file inside your own migration module (for example
`my_migration/migrations/`). The two ways to supply the URLs are mutually
exclusive:

- **`links_list`** — an inline array of URLs to scrape.
- **`links_file`** — the path (relative to the module that defines the migration)
  of a text file with one URL per line. Use this when the list is long.

Then define a `fields` section. Each field names either an `xpath` expression or
a CSS `selector`, plus optional settings:

- **`get`** — `text` (the element's text, the default) or `outerHtml` (the full
  HTML inside the element).
- **`multiple: true`** — collect every matching element into a multi-value field
  rather than just the first.
- **`key`** — a unique identifier for each collected element when
  `multiple: true`, handy for `sub_process`.

A minimal example that scrapes a title and body from a set of pages into article
nodes:

```yaml
id: wikipedia_south_italy
label: 'Scraping wikipedia.org about south Italy'
source:
  plugin: php_scraper
  links_list:
    - 'https://en.wikipedia.org/wiki/Naples'
    - 'https://en.wikipedia.org/wiki/Amalfi_Coast'
  fields:
    title:
      xpath: '//*[@id="firstHeading"]'
      get: text
    body:
      selector: '#bodyContent'
      get: outerHtml
  ids:
    - id
process:
  body/value: body
  body/format:
    plugin: default_value
    default_value: full_html
  title:
    - plugin: callback
      callable: strip_tags
      source: title
destination:
  plugin: 'entity:node'
  default_bundle: article
```

Run it with `drush migrate:import wikipedia_south_italy`, and roll it back with
`drush migrate:rollback wikipedia_south_italy`. Combine the scraped values with
any of Migrate's process plugins to clean, reformat, or map them before they
reach the destination.
