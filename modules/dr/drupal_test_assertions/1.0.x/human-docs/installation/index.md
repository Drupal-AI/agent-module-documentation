# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- A working PHPUnit test setup for your Drupal project (this is a testing
  helper — it is only useful alongside functional/kernel tests).
- No module dependencies, no third‑party runtime Composer packages, and no
  external library requirements.

## Install with Composer

Because this is a testing library, require it as a **development dependency** so
it never ships to production:

```bash
composer require --dev drupal/drupal_test_assertions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require --dev drupal/drupal_test_assertions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enabling

This module ships **no runtime code**, so there is nothing to enable on a live
site — its traits live under `tests/src/` and are available to your test classes
once the package is installed. If your test bootstrap requires the providing
module to be installed for autoloading in kernel/functional tests, enable it in
the test environment only:

```bash
drush en drupal_test_assertions -y
```

Most projects simply `use` the traits directly without enabling anything.

## Verify it worked

Add one of the traits to a test class (see
[How to use it](../index.md#how-to-use-it)) and run your test suite. If the
assertions resolve and run, the library is installed correctly. Nothing changes
on the live site — this package has no effect outside of tests.
