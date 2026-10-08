# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Node** module (`node`) — the only dependency, and part of any standard
  install.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_weight -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_weight -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_weight -y
```

Enabling the module does not change any content type on its own — you switch node
weighting on per type afterwards. See
[How to use it](../index.md#how-to-use-it) on the overview page for enabling a
type, the settings, the ordering screen, and using the weight as a Views sort.
