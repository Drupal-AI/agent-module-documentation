# Installation

> **This is a testing fixture, not a production module.** It intentionally contains
> deprecated Drupal API calls so that drupal‑rector can generate patches against
> it. Do **not** enable it on a live site — use it only in a test or CI
> environment.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** (`filter`) and **System** (`system`) modules — both part of
  standard Drupal.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

In the test/CI project where you run drupal‑rector, from the project root:

```bash
composer require drupal/test_commit_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name
(`drupal/test_commit_message`) matches the module's machine name
(`test_commit_message`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/test_commit_message -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module (test environments only)

If your test flow requires the module to be enabled:

```bash
drush en test_commit_message -y
```

Again — only do this in a throwaway test or CI environment. The module exists to be
a rector target and offers no site functionality. See the [main guide](../index.md)
for how it is used.
