# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- A **New Fangled Insight Engine** account, so you can generate an API **token**
  for either the Sandbox or Production environment.
- **Webform** is optional — install it only if you want form‑submission conversion
  tracking.

There are no third‑party PHP library requirements and no required module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/nf_insight_engine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nf_insight_engine -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nf_insight_engine -y
```

## Verify it worked

Open the module's settings form (from **Extend**, click **Configure** next to New
Fangled Insight Engine, or find it under **Configuration**). If the form loads and
you can enter a token and choose an environment, the module is installed. Continue
with [Configuration](../configuration/index.md).
