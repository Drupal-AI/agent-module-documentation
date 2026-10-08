# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — Drupal enables it as a dependency.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_button_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_button_modal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_button_modal -y
```

There is no configuration form. Once enabled, the modal-button option appears on
each block's configuration form under **Structure → Block layout** — see
[How to use it](../index.md#how-to-use-it).
