<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Source Scraper adds a `php_scraper` Migrate source plugin that fetches web pages and extracts field values with XPath or CSS selectors.

---

The module registers a single migrate source plugin (`@MigrateSource(id = "php_scraper")`) in `src/Plugin/migrate/source/MigratePhpScraper.php`. A migration YAML supplies either a `links_list` (inline array of URLs) or a `links_file` (a newline-delimited file resolved relative to the migration module directory) — the two are mutually exclusive. For each link the plugin instantiates `ScrapingClient` (a thin subclass of Symfony `HttpBrowser` using the native `HttpClient`), performs a GET, and runs each configured field's `xpath` or `selector` filter over the returned `Crawler`, optionally with `multiple: true` to collect repeated nodes and a `get` method (`text`, `html`, attribute, etc.).

The scrape URLs come exclusively from the migration definition authored by a developer; there is no route, form, or web-facing input, so the fetch target is not attacker-controllable and the plugin only runs during `drush migrate:import`. TLS verification uses Symfony HttpClient defaults (enabled). Use it to seed content from legacy or third-party sites you control or are authorised to scrape.

---
- Import content into Drupal by scraping remote HTML pages.
- Define scrape targets inline via a `links_list` array in the migration.
- Read a long URL list from a `links_file` next to the migration.
- Extract a field value with an XPath expression.
- Extract a field value with a CSS selector.
- Collect repeated elements into a multi-value field with `multiple: true`.
- Pull element text, inner HTML, or an attribute via the `get` option.
- Migrate a legacy static site into Drupal nodes.
- Seed a catalogue from a supplier's product pages you are allowed to scrape.
- Combine with Migrate process plugins to clean scraped values.
- Run repeatable imports through `drush migrate:import`.
- Roll back scraped content with `drush migrate:rollback`.
- Track scraped rows with the standard migrate map tables.
- Reuse one migration definition across many source URLs.
- Prototype a content model from real-world sample pages.
- Keep scrape logic in version-controlled migration YAML.
