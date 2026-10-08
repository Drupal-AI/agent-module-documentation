# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- **PHP 8.1 or newer**.
- No modules outside Drupal core are required.

There are no additional third‑party library requirements. This release is an early
(alpha) version — test it before relying on it in production. Note the project is
**not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/scanner_fixer_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scanner_fixer_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scanner_fixer_api -y
```

Because this is a code‑only framework, enabling it adds the plugin types, the
solutions overview page and the Drush commands, but nothing runs until you define
at least one Solution in code.

## Optional: the example submodule

The **`scanner_fixer_api_example`** submodule provides a worked example and
documentation for building Scanner, Fixer and Solution plugins:

```bash
drush en scanner_fixer_api_example -y
```

## Verify it worked

List the defined Solutions from the command line:

```bash
drush scanner-fixer:list-solutions
```

With the example submodule enabled you should see its example Solution listed, and
it should also appear at **`/admin/content/scanner_fixer_api`** for users who have
the overview permission.
