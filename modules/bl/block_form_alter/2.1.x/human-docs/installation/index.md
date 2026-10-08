# Installation

## Requirements

Block Form Alter needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) enabled — its only dependency, and part of
  standard Drupal.

There are no third-party Composer or PHP library requirements. Layout Builder is not
required, but the module's hooks also cover Layout Builder block forms when Layout
Builder is in use.

## Install with Composer

From the project root:

```bash
composer require drupal/block_form_alter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_form_alter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_form_alter -y
```

Enabling the module has no visible effect on its own — it simply makes the two alter
hooks available. To use them, implement one of the hooks in a custom module and run
`drush cr` so it is discovered; see
[How to use it](../index.md#how-to-use-it) in the overview.
