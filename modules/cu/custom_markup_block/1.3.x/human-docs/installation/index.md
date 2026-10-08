# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) — enabled automatically as a dependency (it's
  part of a standard Drupal install anyway).
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_markup_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_markup_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_markup_block -y
```

## Verify it worked

Log in as a user with the **Administer blocks** permission, go to **Structure → Block
layout**, and click **Place block**. You should find **Custom markup block** in the
list. Place it, add some markup, pick a text format, and save — see the main guide's
[How to use it](../index.md#how-to-use-it). Since the content lives in configuration,
you can then export it with `drush cex` and commit it for deployment.
