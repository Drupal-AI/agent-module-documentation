# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/trim -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/trim -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en trim -y
```

That is the entire setup — there is nothing to configure. From this moment, every
content entity form trims surrounding whitespace from its text values before
validation.

## The one piece of state: module weight

The only thing the install step "sets" is Trim's module weight, written to
`core.extension` as **1001**. This deliberately high weight ensures Trim's
form-alter runs last, which in turn places its trimming validator first — so
trimming happens before any field-level or form-level validation. You normally
never touch this. You can confirm it with:

```bash
drush config:get core.extension module.trim
```
