# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** — the underlying SimpleComplex Inspect library requires it.
- No other Drupal modules are required; the SimpleComplex Inspect library it
  depends on is pulled in by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/inspect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the SimpleComplex Inspect library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inspect -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inspect -y
```

> **Development tool.** Enable Inspect where you are diagnosing code — typically a
> local or staging environment. Avoid leaving it enabled on production, since it
> exists to dump runtime data (see the caution in the [overview](../index.md)).

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). To check it
works, add a quick call to the `inspect.inspect` service in code you can trigger,
then look in **Reports → Recent log messages** for the formatted dump or trace it
produced.
