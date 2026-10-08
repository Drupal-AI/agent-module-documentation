# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- A **formatted‑text field** (such as the core Body field) to apply the formatter
  to. The module works with standard Field UI, so no extra field types are
  needed.

There are no third‑party Composer or PHP library requirements, and the module
adds no routes or permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/body_index -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/body_index -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en body_index -y
```

Once enabled, the **Body Index** formatter is available on the **Manage display**
screen for any formatted‑text field — see
[How to use it](../index.md#how-to-use-it).
