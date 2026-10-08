# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). It does not declare
  Drupal 11 support.
- No contrib module dependencies. However, the **rebuild** feature runs a
  JavaScript **runtime (npm or yarn)** on the server, so those tools must be
  available in the environment where rebuilds run.

> **Support status:** this project is marked **Unsupported** with no further
> development. Consider that before relying on it for new work.

## Install with Composer

From the project root:

```bash
composer require drupal/entrypoints -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entrypoints -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entrypoints -y
```

## Verify it worked

Go to **`/admin/config/entrypoints`**. You should see the Entrypoints settings
form. See [Configuration](../configuration/index.md) for the settings, the
rebuild workflow, and the permissions you need to grant.
