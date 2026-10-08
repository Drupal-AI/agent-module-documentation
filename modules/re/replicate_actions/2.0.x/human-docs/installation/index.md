# Installation

## Requirements

- **Drupal 10.1 or newer, Drupal 11, or Drupal 12** (`core_version_requirement:
  ^10.1 || ^11 || ^12`).
- **Replicate** (`drupal/replicate` `^1.0`) and **Replicate UI**
  (`drupal/replicate_ui` `^1.0`) — this module extends them, and both must be
  present. Composer pulls them in automatically with the command below.
- If you want the "re-add to the same Groups" behaviour, you'll also need the
  **Group** module installed and in use — but it is optional.

## Install with Composer

From the project root:

```bash
composer require drupal/replicate_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Replicate and
Replicate UI (and any shared dependencies) alongside this module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/replicate_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en replicate_actions -y
```

Enabling it also enables Replicate and Replicate UI if they weren't already on.
The new clone-behaviour applies immediately the next time you duplicate content.

To adjust the one available setting, see [Configuration](../configuration/index.md).
