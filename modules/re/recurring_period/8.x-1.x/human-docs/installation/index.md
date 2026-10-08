# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The contrib **[Interval](https://www.drupal.org/project/interval)** module
  (`interval`), which supplies the interval field/logic Recurring Period builds
  on. Composer pulls it in with the `-W` flag below, and Drupal enables it as a
  dependency.

There are no third‑party PHP library requirements. Note that while Recurring
Period was written for **Commerce License** and **Commerce Recurring**, it does
**not** require any Commerce module — you can use it standalone.

## Install with Composer

From the project root:

```bash
composer require drupal/recurring_period -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Interval and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recurring_period -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recurring_period -y
```

Drupal enables Interval automatically as a dependency. In most cases you will not
enable Recurring Period by hand at all — the module that needs it (such as
Commerce License or Commerce Recurring) will enable it for you.

## Verify it worked

There is no admin page to check. Confirm the module is enabled with `drush pm:list
--type=module --status=enabled | grep recurring_period`. Its period plugins then
become available to any module that consumes them.
