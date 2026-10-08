# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.1 or later** (`php: 8.1`) — the module is built on PHP enums, which do
  not exist before 8.1.
- Core's **Options** module (`options`) — Drupal enables it automatically as a
  dependency.

There are no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/enum_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/enum_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en enum_field -y
```

## Verify it worked

On any bundle, go to **Manage fields → Add field**. The **Enum (text)** and
**Enum (integer)** field types should appear in the list. Add one, point it at a
backed PHP enum class, and follow [How to use it](../index.md#how-to-use-it) to
wire it up.
