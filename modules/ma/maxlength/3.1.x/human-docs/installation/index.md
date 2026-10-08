# Installation

## Requirements

MaxLength is lightweight and depends only on core:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib module dependencies, and no third‑party Composer or PHP libraries.

If the **CKEditor 5** module is enabled, MaxLength automatically hooks its counter
into the rich‑text editor, so the countdown works inside CKEditor too — but that is
optional and requires no extra setup.

## Install with Composer

From the project root:

```bash
composer require drupal/maxlength -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maxlength -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maxlength -y
```

Enabling the module does not change any field on its own — nothing happens until you
switch MaxLength on for a specific field's widget. Head to
[Configuration](../configuration/index.md) to set a limit on your first field.
