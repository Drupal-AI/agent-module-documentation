# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- **PHP 8.3, 8.4, or 8.5** (`php: ^8.3 || ^8.4 || ^8.5`).
- Core's **Language** module (`language`) and **Block** module (`block`) enabled
  — these are the only dependencies, and Drupal enables them automatically.
- A genuinely multilingual site (two or more configured languages). The block
  stays hidden while the site has only one language, unless you turn on the
  "always show block" option.

There are no external libraries to download and no third‑party Composer
requirements beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/dropdown_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dropdown_language -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dropdown_language -y
```

Or enable **Dropdown Language Switcher** from **Extend** (`/admin/modules`).

## Next steps

Add a second language (if you have not already) under **Configuration → Regional
and language → Languages**, then place the **Dropdown Language** block and adjust
its label style — see [Configuration](../configuration/index.md).
