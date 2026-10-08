# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements. The module
provides an `administer body_inject profiles` permission for controlling access
to its profiles.

> **Note:** This release is a beta version, so test it on a non‑production copy of
> your site before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/body_inject -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/body_inject -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en body_inject -y
```

After enabling, grant **`administer body_inject profiles`** to trusted
administrators only, then create your inject profiles — see
[How to use it](../index.md#how-to-use-it).
