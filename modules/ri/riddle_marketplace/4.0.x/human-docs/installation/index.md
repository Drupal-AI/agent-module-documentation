# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- A **Riddle** account with an API token (this 4.x branch uses Riddle API v3).
- Core's **Media** system, which the media submodule builds on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/riddle_marketplace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/riddle_marketplace -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en riddle_marketplace -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Media Riddle Marketplace** | `media_riddle_marketplace` | Adds the Riddle **media entity/type**, so imported riddles live in Drupal's media system and can be reused across content. Enable this if you want to manage riddles as media (the usual choice). |

To enable it:

```bash
drush en media_riddle_marketplace -y
```

## Verify it worked

Log in as an administrator. You should be able to reach the module's settings to
enter your Riddle API credentials (see [Configuration](../configuration/index.md)),
and — once the media submodule is on — create Riddle media in your media library.
