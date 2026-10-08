# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **EditionGuard API** module (`editionguard_api`) — a hard dependency that
  holds the API credentials and does the actual talking to EditionGuard. Composer
  pulls it in automatically.
- An **EditionGuard account** and API credentials (see
  [Configuration](../configuration/index.md)).
- No additional PHP library requirements.

Note that this project's security advisory coverage is *not* covered by the Drupal
Security Team — weigh that for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/editionguard -W
```

The `-W` flag lets Composer bring in the required `editionguard_api` module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/editionguard -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editionguard -y
```

Enabling `editionguard` also enables its required `editionguard_api` dependency.

## Submodules

| Submodule | What it adds |
|-----------|--------------|
| `rh_editionguard_book` | Adds [Rabbit Hole](https://www.drupal.org/project/rabbit_hole) behavior to EditionGuard book entities. Enable it only if you use Rabbit Hole. |

```bash
drush en rh_editionguard_book -y
```

## Verify it worked

Confirm the module and its API dependency are on:

```bash
drush pm:list --status=enabled | grep editionguard
```

You should see `editionguard` and `editionguard_api`. The module is installed, but
you still need to configure the EditionGuard API credentials before you can create
books and transactions. Continue to [Configuration](../configuration/index.md).
