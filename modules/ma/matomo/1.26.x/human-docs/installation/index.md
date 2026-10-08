# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- Core's **Path Alias** module (`path_alias`) — Drupal enables it automatically as
  a dependency.
- A **Matomo instance** to send data to — either a self-hosted Matomo server or a
  Matomo Cloud account. You will need its URL and your site ID.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/matomo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/matomo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en matomo -y
```

Nothing is tracked until you enter your site ID and server URL on the settings
form — see [Configuration](../configuration/index.md).

## Submodule — Matomo Tag Manager

The project bundles one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Matomo Tag Manager** | `matomo_tagmanager` | Manages Matomo Tag Manager (MTM) container snippets instead of the classic page tracker. Enable it if you drive your tracking through MTM containers. |

Enable it only if you need it:

```bash
drush en matomo_tagmanager -y
```
