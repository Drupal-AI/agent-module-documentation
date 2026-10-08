# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- A **Localize project key** — sign up at
  [localizejs.com](https://localizejs.com) and grab your project key from the
  dashboard.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localizejs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localizejs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localizejs -y
```

## Verify it worked

After you enter your project key (see [Configuration](../configuration/index.md)),
load any front-end page and view its HTML source in the browser. You should see the
Localize.js JavaScript added in the page header. That confirms the widget is being
injected.
