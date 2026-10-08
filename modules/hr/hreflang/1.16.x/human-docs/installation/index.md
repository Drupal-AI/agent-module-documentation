# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **multilingual site** — that is, more than one language enabled (core's
  **Language** module, and usually **Content Translation** and **Interface
  Translation**). Hreflang only emits tags when the site actually has multiple
  languages; on a single‑language site it stays silent.

There are no third‑party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/hreflang -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hreflang -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hreflang -y
```

Once enabled on a multilingual site, Hreflang immediately begins adding hreflang
tags to every page with no further setup. If you want to tweak the `x-default`
behavior, see [Configuration](../configuration/index.md).

There are no submodules.
