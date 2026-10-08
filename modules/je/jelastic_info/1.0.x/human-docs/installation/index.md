# Installation

## Requirements

- **Drupal 10.3 or later, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- A site actually **hosted on Jelastic or the Virtuozzo Application Platform** —
  the dashboard reads that platform's API, so it has nothing to show elsewhere.
- A **Personal Access Token** from your Jelastic dashboard (read‑only scope is
  enough).

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jelastic_info -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jelastic_info -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jelastic_info -y
```

## Verify it worked

Enabling the module makes **Reports → Jelastic environment** appear. Until you add
a Personal Access Token it will report that it isn't connected yet — that's
expected. Follow [Configuration](../configuration/index.md) to add the token and
pick your environment, then reload the report to see live environment data.
