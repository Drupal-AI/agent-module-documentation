# Migrate Process Newspaper Playwright — manual setup guide

**Migrate Process Newspaper Playwright** (`migrate_process_newspaper_playwright`)
is a Migrate *process plugin* that scrapes an article from a URL during a
migration and returns it as a structured array — title, body text, images,
authors, publish date, HTML, and assorted metadata. It is a close cousin of
Migrate Process Newspaper3k, but with one important difference: it drives the
Python **Newspaper3/4k** scraper through a **Playwright** browser wrapper, so it
can render **JavaScript‑heavy pages** that a plain HTTP fetch cannot read.

This solves the "the article is built by JavaScript" problem. Many modern news
and blog pages assemble their content client‑side; fetching the raw HTML gets you
an empty shell. Playwright launches a real headless browser, lets the page
render, and *then* hands the DOM to Newspaper for parsing — so you get the
article you actually see in a browser.

Because of that, the prerequisites are heavier than the plain Newspaper3k module.
Your server needs **Python 3**, **Playwright** (plus the browser it drives), and
the Composer package
[`2dareis2do/newspaper-playwright-wrapper`](https://packagist.org/packages/2dareis2do/newspaper-playwright-wrapper).
The plugin **spawns a local Python process** on the web server and **fetches the
target URL server‑side**, so treat the URLs and the `command`/`cwd` values as
trusted, developer‑supplied migration configuration (they are not request input),
and account for the outbound network egress that scraping remote pages involves.
The module depends only on core **Migrate** and has no admin pages — you use it
from your migration YAML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, the Composer
   wrapper, and the Python/Playwright prerequisites.

There is **no configuration page** for this module — it has no settings form.
Everything is set from the migration YAML, as shown below.

## How to use it

Feed the plugin a URL, then use `get`/`extract` downstream to pull out the keys
you want:

```yaml
process:
  _scraped:
    - plugin: get
      source: link
    - plugin: migrate_process_newspaper_playwright
      debug: false        # default false; true dumps the scraper JSON to /tmp
      command: python3     # optional path to the Python interpreter
      cwd: '../python'     # optional working dir of ArticleScraping.py (relative to docroot)
  _title:
    - plugin: get
      source: '@_scraped'
    - plugin: extract
      index: [ _title ]
```

The returned array uses underscore‑prefixed keys: `_title`, `_text`, `_summary`,
`_top_img`/`_top_image`, `_imgs`/`_images`, `_authors`, `_publish_date`, `_html`,
`_article_html`, `_meta_description`, `_keywords`, `_tags`, and more.

A few practical notes:

- `transform()` only runs for absolute `http(s)` URLs; anything else is passed
  over. On error the plugin logs a notice and returns an empty string, so pairing
  it with `skip_on_empty` is a good idea.
- `cwd` lets you point at your own `ArticleScraping.py` script per migration, so
  different migrations can use different scraper configurations.
- On older Linux distributions you may be pinned to an older Playwright (for
  example Playwright 1.30 on pre‑glibc‑2.27 systems) — see Installation.
