# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core **Media**, **File**, and **Image** modules (part of a standard install).
- Two contributed dependencies, installed automatically with the module:
  - **`drupal/acquia_dam`** (`^1.1.2`) — the newer Acquia DAM module this 2.x release
    bridges to.
  - **`drupal/fallback_formatter`** (`^1.0`).
- An **Acquia DAM (Widen) account** and your DAM **domain**, plus the ability for
  editors to authenticate against it.

## Install with Composer

From the project root:

```bash
composer require drupal/media_acquiadam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies and
install `acquia_dam` and `fallback_formatter` alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_acquiadam -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_acquiadam -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Example** | `media_acquiadam_example` | Example media types, fields, and displays to bootstrap a working setup. |
| **Report** | `media_acquiadam_report` | A Views-based report of DAM asset usage across the site. |

```bash
drush en media_acquiadam_example -y
drush en media_acquiadam_report -y
```

After enabling, connect your DAM domain and token and set the sync options — see
[Configuration](../configuration/index.md).
