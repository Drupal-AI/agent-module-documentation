# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Bontact account** with a widget/account identifier, so you have something to
  connect the widget to.

There are no third‑party Composer or PHP library requirements. No secret API key
is needed — only your public Bontact widget/account identifier. The module
provides its own permission for controlling who may configure it.

> **Note:** This release is a development (`2.0.x-dev`) version, so test it on a
> non‑production copy of your site before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/bontact -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bontact -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bontact -y
```

After enabling, enter your Bontact widget/account identifier in the module's
settings — see [How to use it](../index.md#how-to-use-it).
