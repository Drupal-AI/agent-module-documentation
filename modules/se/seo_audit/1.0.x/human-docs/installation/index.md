# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Queue UI** module (`queue_ui`) — SEO Audit uses it for queued,
  cron-driven background crawling. Install it from drupal.org if it is not
  already on your site.
- Outbound HTTP access from the server so the crawler can fetch your pages (this
  works against live, staging, and local sites).

There are no third-party PHP libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/seo_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Queue UI is not present yet, Composer will pull it in
as a dependency; you can also add it explicitly with
`composer require drupal/queue_ui -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/seo_audit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seo_audit -y
```

Drupal enables Queue UI as a dependency if it is not already on.

## Verify it worked

Go to **Configuration → Search and metadata → SEO Audit** and confirm you can
reach the settings page at `/admin/config/search/seo-audit/settings`, the crawl
request page at `/admin/config/search/seo-audit/crawl`, and the results page at
`/admin/config/search/seo-audit/results`. Because the crawl runs through the
queue and cron, make sure cron is running (or process the queue manually) so
requested audits actually complete.
