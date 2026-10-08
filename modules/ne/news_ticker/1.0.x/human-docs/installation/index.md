# Installation

## Requirements

- **Drupal 10.6 or Drupal 11.3 and later** — the project targets these supported
  versions (`core_version_requirement: ^10 || ^11`).
- Core only — no module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/news_ticker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/news_ticker -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en news_ticker -y
```

## Verify it worked

Create a news list with a few items, then place the **News Ticker** block (see
"How to use it" in the [overview](../index.md)) and view the page. You should see
your headlines scrolling, with pause-on-focus and reduced-motion behavior working
as expected.
