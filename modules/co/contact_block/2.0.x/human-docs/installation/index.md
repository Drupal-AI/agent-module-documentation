# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** (`block`) and **Contact** (`contact`) modules — Drupal enables
  them automatically as dependencies. You will also want at least one contact form
  configured under Structure → Contact forms.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contact_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_block -y
```

Once enabled, the **Contact block** is available to place from **Structure → Block
layout**. There is no separate settings page and there are no submodules — see
[How to use it](../index.md#how-to-use-it) for placing and configuring the block.
