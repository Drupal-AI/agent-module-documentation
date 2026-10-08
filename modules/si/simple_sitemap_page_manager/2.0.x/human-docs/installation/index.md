# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Panels** (`panels`) — required; this is the project that provides Page Manager.
- **Simple XML Sitemap** (`simple_sitemap`) — required. This 2.0.x release targets
  Simple Sitemap 4.x.

No external libraries or PHP requirements.

## Install with Composer

Composer will pull in the required modules if you don't already have them. From the
project root:

```bash
composer require drupal/simple_sitemap_page_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name,
`drupal/simple_sitemap_page_manager`, matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_sitemap_page_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_sitemap_page_manager -y
```

Make sure Page Manager itself is enabled (it comes with Panels). Once this module
is on, the sitemap controls appear on each Page Manager page's **General** tab and
in a new tab under the Simple XML Sitemap settings — see the **How to use it**
section of the [main guide](../index.md).
