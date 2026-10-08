# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No modules outside Drupal core are required.
- The module fetches quotes from Wikiquote, so the site needs outbound network
  access to that external source.

## Install with Composer

From the project root:

```bash
composer require drupal/thesimpsons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/thesimpsons -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en thesimpsons -y
```

## Verify it worked

Place the block (see [Configuration](../configuration/index.md)) and reload the
page — you should see a random Simpsons quote appear in the region you chose.
