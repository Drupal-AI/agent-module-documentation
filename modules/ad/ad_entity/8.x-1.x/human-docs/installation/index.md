# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contributed **Entity API** module (`entity`) — Advertising Entity depends
  on it. Composer pulls it in automatically when you require this module.
- For each provider you use, an account with that ad platform (for example a
  Google Ad Manager network for the DFP submodule).

## Install with Composer

From the project root:

```bash
composer require drupal/ad_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
Entity API module and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ad_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ad_entity -y
```

## Provider submodules — enable your ad platform

Advertising Entity uses pluggable providers shipped as submodules. Enable the one
that matches your platform:

| Submodule | Machine name | Provider |
|-----------|--------------|----------|
| **DFP** | `ad_entity_dfp` | Google Ad Manager (formerly DoubleClick for Publishers). |
| **AdTech** | `ad_entity_adtech` | AdTech (v1). |
| **AdTech v2** | `ad_entity_adtech_v2` | AdTech (v2). |
| **Generic** | `ad_entity_generic` | A generic provider for other ad code. |
| **Fallback** | `ad_entity_fallback` | Shows a fallback when a slot has nothing to serve. |

For example, for Google Ad Manager:

```bash
drush en ad_entity_dfp -y
```

Each submodule requires the base Advertising Entity module. After enabling, create
your ad entities and configure placement — see the
[main guide](../index.md#how-to-use-it) — and gate the ad scripts behind consent
where required.
