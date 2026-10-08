# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement:
  ^10.2||^11`).
- No contrib module dependencies — Currency API is a lightweight standalone
  module (compatible with, but not requiring, Commerce).
- No third‑party PHP or JavaScript libraries.
- A **currencyapi.com account and API key** (a free tier is available). You'll
  add the key during [configuration](../configuration/index.md).
- Working **cron**, since rate updates are cron‑driven.

## Install with Composer

From the project root:

```bash
composer require drupal/currencyapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/currencyapi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en currencyapi -y
```

## Verify it worked

Open the **Currency API settings** form (see
[Configuration](../configuration/index.md)) and confirm it loads. Once you've
entered your API key and run cron, the module should fetch rates that you can then
display via a block, View, or template.
