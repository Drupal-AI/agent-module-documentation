# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — enabled automatically as a dependency.
- The Composer package **`2dareis2do/newspaper-playwright-wrapper`**, which the
  plugin instantiates to do the scraping.
- **A server that can run a Python 3 script**, with **Playwright** and its
  browser installed. On older distributions the latest Playwright may not run —
  Playwright's browsers need glibc 2.27 or later — so on something like CentOS 7
  you may need to pin an older release (`pip3 install playwright==1.30.0`). Note
  that older Playwright versions are less fully featured.

Because the plugin launches a browser and fetches remote pages from the server,
ensure outbound HTTP(S) egress is allowed, and only scrape trusted URLs supplied
by your migration definitions.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_process_newspaper_playwright -W
```

Then require the Python wrapper package (if Composer has not already pulled it in
as a dependency):

```bash
composer require 2dareis2do/newspaper-playwright-wrapper -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_process_newspaper_playwright -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the Python / Playwright prerequisites

Install Playwright and its browser on the web server (inside the container for
DDEV):

```bash
pip3 install playwright
python3 -m playwright install
```

Follow the wrapper's own README for the exact setup of the `ArticleScraping.py`
script and where to place it; you point the plugin at it with the `cwd` option
(relative to the docroot, e.g. `/var/www/html/web`).

## Enable the module

```bash
drush en migrate_process_newspaper_playwright -y
```

## Verify it worked

Add the `migrate_process_newspaper_playwright` plugin to a migration with a known
JavaScript‑rendered article URL and run `drush migrate:import`. If you set
`debug: true`, the raw scraper JSON is written to `/tmp`, which is the quickest
way to confirm the Python/Playwright chain is working end to end.
