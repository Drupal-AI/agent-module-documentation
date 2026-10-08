<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Source Scraper (migrate_source_scraper) — agent index

**A `php_scraper` Migrate API source plugin that scrapes remote HTML (Symfony BrowserKit + DomCrawler) into migration rows.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends:** drupal:migrate
- **Surface:** one migrate source plugin (`id = php_scraper`); no routes, forms, services, or permissions.

**Config keys (in a migration YAML):** `links_list` *or* `links_file` (mutually exclusive), plus `fields` where each entry has `xpath` or `selector`, optional `multiple` (bool) and `get` (method, default `text`).

**Security:** scrape URLs come only from developer-authored migration definitions and run under Drush — not attacker-controllable, no SSRF surface. `ScrapingClient` extends Symfony `HttpBrowser`; TLS verification is left at HttpClient defaults (on). No web endpoints.
