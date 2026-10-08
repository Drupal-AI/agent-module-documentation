# Installation

## Requirements

- **Drupal 9.2+, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **Drush**, since the tool wraps Drush operations.

There are no third-party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_dialog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drush_dialog -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_dialog -y
```

## Verify it worked

After enabling, open the overlay, type a simple Drush command (for example
`core:status`) into its input field, and confirm the output is shown back. See the
[main guide](../index.md) for how to use it. Keep access limited to trusted
administrators.
