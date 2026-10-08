# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A number of core modules, which are enabled automatically as dependencies:
  **Content Moderation**, **Datetime**, **Field**, **Link**, **Menu UI**, **Node**,
  **Path**, **Taxonomy**, and **Text**.

LocalGov News is part of the LocalGov Drupal distribution but can be installed on its own.
There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_news -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_news -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_news -y
drush cr
```

The description mentions an optional Newsroom sub-module, but this project (`localgov_news`)
ships no bundled submodules to enable separately. After enabling, continue to
[Configuration](../configuration/index.md) — the first thing to do is create a newsroom,
because articles require one.
