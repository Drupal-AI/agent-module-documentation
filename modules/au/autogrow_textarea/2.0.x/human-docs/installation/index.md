# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party module, Composer, or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autogrow_textarea -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autogrow_textarea -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autogrow_textarea -y
```

The module ships no submodules and needs no configuration — textareas begin
auto‑resizing as soon as it is enabled.
