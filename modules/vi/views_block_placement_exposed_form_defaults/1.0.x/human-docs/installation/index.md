# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Views** module (`views`) and **Block** module (`block`), both enabled.
  Drupal enables them as dependencies automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_block_placement_exposed_form_defaults -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/views_block_placement_exposed_form_defaults -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_block_placement_exposed_form_defaults -y
```

There are no submodules and no configuration screen. Once enabled, the new
**"Customizable filters"** option appears in the *Allow settings* of any view's
Block display — see [How to use it](../index.md#how-to-use-it) on the overview
page.
