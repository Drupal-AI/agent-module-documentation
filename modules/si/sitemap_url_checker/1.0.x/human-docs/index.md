# Sitemap URL Checker — manual setup guide

**Sitemap URL Checker** (`sitemap_url_checker`) reads the URLs listed in your
site's XML sitemap and checks each one's HTTP status, reporting any that come back
as errors (4xx or 5xx — for example 404 Not Found or 500 Internal Server Error).
It gives a site owner a quick way to find broken or erroring pages that are still
being advertised to search engines.

The problem it solves is sitemap hygiene. A sitemap that points crawlers at
broken URLs wastes crawl budget and hurts SEO. This module audits your
`/sitemap.xml` entries and shows you exactly which URLs are failing, so you can fix
or remove them and keep the sitemap clean.

It works as an on‑demand audit rather than something you configure: once the
module is enabled and a sitemap is available, you open the checker page and it
lists the broken URLs it finds in a paginated table, which you can also export as
a CSV file. It depends on a working `/sitemap.xml` endpoint, which the **Simple XML
Sitemap** module (`simple_sitemap`) provides — that is a hard dependency. It
supports Drupal 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with Simple XML Sitemap).

## Where it lives in the admin menu

The checker lives at **Configuration → Search and metadata → Broken URLs**
(`/admin/sitemap-urlchecker`). Open it to run the check.

## How to use it

1. Make sure your sitemap is available at `/sitemap.xml` — generate it with a
   sitemap module such as **Simple XML Sitemap**.
2. Go to **Configuration → Search and metadata → Broken URLs**
   (`/admin/sitemap-urlchecker`).
3. The module checks the sitemap's URLs and, if any return 4xx or 5xx status
   codes, lists them in a paginated table.
4. Export the results as a **CSV file** if you want to work through them offline
   or share them with the team.
