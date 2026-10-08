# SEO Audit — manual setup guide

**SEO Audit** (`seo_audit`) crawls your Drupal site the way a search engine
would, page by page, and reports the SEO problems it finds so you can fix them.
It is designed to run against any site — live, staging, or even a local
development environment — needing only an internet connection.

The module drives its crawl through a queue, integrated with Drupal's cron, so
large sites can be audited without timeouts or memory blow-ups. As it goes it
looks for the on-page issues that hurt search visibility: missing H1 tags, broken
links, images without alt text, improper or missing meta tags, and similar
factors. It then produces clear, prioritised reports you can read on screen or
export as PDF, CSV, or JSON, with colour-coded HTTP status indicators for quick
scanning. It respects `robots.txt`, supports locally hosted virtual hosts, and
each user sees only their own crawl results.

Because it crawls, SEO Audit needs a little configuration before a first run and
some care in operation. You choose the crawl scope and which checks to run on its
settings page, then request a crawl and view the results. Note that crawling
makes real server-side HTTP requests and generates load, and the crawl target is
admin-configured (usually the site itself), so restrict who can trigger audits
and schedule them sensibly. The module reads pages to report on them — it never
changes your content and plays no access-control role. It depends on the
**Queue UI** module for its queued background processing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Queue UI.
2. [Configuration](configuration/index.md) — set the crawl scope, choose which
   checks run, and run your first audit.

## Where it lives in the admin menu

Everything sits under **Configuration → Search and metadata → SEO Audit**
(settings route `seo_audit.settings`). The three working pages are:

- **Request a crawl** — `/admin/config/search/seo-audit/crawl`
- **Configure crawl settings** — `/admin/config/search/seo-audit/settings`
- **View crawl results** — `/admin/config/search/seo-audit/results`
