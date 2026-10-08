# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contributed **Webform** module (`webform`) — a hard dependency, since the
  popup embeds a webform.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dopup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and any
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dopup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dopup -y
```

Drupal will prompt to enable Webform as a dependency if it is not already on.

## Verify it worked

After enabling, go to **Structure → Block layout** and confirm a **Dopup** block
is available to place. Once you have created and tagged a webform and configured a
block (see [Configuration](../configuration/index.md)), load a front‑end page and
confirm the popup appears according to the trigger you set.
