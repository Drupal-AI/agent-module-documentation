# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Language** (`language`) and **User** (`user`) modules enabled. Language
  is enabled automatically as a dependency; you should have configured more than
  one language for the module to be useful.

There are no third‑party Composer or PHP library requirements. Simple Sitemap and
TMGMT are integrated with when present, but neither is required.

## Install with Composer

From the project root:

```bash
composer require drupal/language_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/language_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_access -y
```

On enable, the module grants **Access language *(default)*** to the anonymous and
authenticated roles so your default language keeps working for everyone. Every
other language is now locked until you grant its permission on **People →
Permissions** — see the module overview for how to use it.

This module has no submodules and no settings form.
