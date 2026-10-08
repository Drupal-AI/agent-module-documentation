# Scrape to field — manual setup guide

**Scrape to field** (`scrape_to_field`) pulls content from external web pages and
uses it to populate fields on your Drupal nodes automatically. It is a good fit for
keeping dynamic values fresh — product prices, news snippets, stock information, or
any content that lives on a third-party site — without hand-copying it every time.

What sets it apart is that scraping is configured **per field, per node**. Each
field can have its own source URL, its own CSS or XPath selector, its own
extraction method and its own update frequency. You can also clean the scraped
value with search-and-replace before it is stored, and test a configuration
in-place to preview the result before saving. The actual fetching runs in the
background through Drupal's cron and queue system, so it does not slow down page
loads — which does mean **cron must be enabled and running regularly** for scraping
to happen.

Scraping is an administrative capability: which fields are scraped and from which
URLs is set by users with the appropriate permission (the source URLs are
admin-supplied, not visitor-supplied). The module depends only on core's **Field**
module and supports **Drupal 11**.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — the global settings, the per-field
   scraping options, and the permissions that control access.

## Where it lives in the admin menu

Global settings are at **Configuration → Content authoring → Scrape to field
Settings** (`/admin/config/content/web-scraper`). Per-field scraping is configured
from the **Scraper Config** tab on an individual node.
