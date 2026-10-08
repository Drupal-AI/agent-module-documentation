# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contrib **Search API** module (`drupal/search_api`, `~1.26`) — this module
  is a processor for it, so Search API must be present and enabled.
- Two Symfony libraries used to parse and match HTML, pulled in automatically by
  Composer:
  - **symfony/dom-crawler** (`^3.4` through `^8.0`)
  - **symfony/css-selector** (`^2.0` through `^8.0`)

Because of those library requirements, install this module with Composer rather
than by dropping files in manually — Composer resolves the DomCrawler and
CssSelector packages for you.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_html_element_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Search API and the
Symfony libraries as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/search_api_html_element_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_html_element_filter -y
```

There are no submodules. Once enabled, the **HTML Element Filter** processor
becomes available on the Processors tab of any Search API index — see
[Configuration](../configuration/index.md).
