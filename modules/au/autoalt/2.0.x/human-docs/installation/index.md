# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`), enabled — Drupal enables it automatically as
  a dependency.
- An **AutoAlt.ai account and API key** (from https://autoalt.ai). Generating alt
  text consumes credits tied to that key.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autoalt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/autoalt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autoalt -y
```

## After enabling

- Enter your AutoAlt.ai API key on the settings form, as described in
  [Configuration](../configuration/index.md).
