# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Token** module (`drupal/token`), which provides the token
  framework this module plugs into. Drupal enables it automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/theme_tokens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
Token module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/theme_tokens -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en theme_tokens -y
```

This also enables the Token module if it isn't already on. There is no
configuration step — the four `[theme:…]` tokens are available immediately
wherever Drupal token replacement runs (see
[How to use it](../index.md#how-to-use-it)).

## Submodules

Theme Tokens ships no submodules.
