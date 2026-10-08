# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** — required by the underlying PHP library.
- No other Drupal modules are required.
- **Tailwind CSS 4.x** in your theme — this 2.x module line is built for Tailwind 4.
  (Use module 1.x if your project is on Tailwind CSS 3.x.)

### About the PHP library

The module relies on a third-party PHP package to do the actual class merging, and
Composer installs it automatically for you. For this 2.x line (Tailwind CSS 4.x)
that package is `tales-from-a-dev/tailwind-merge-php`; the 1.x line uses
`gehrisandro/tailwind-merge-php`. You do not need to require these yourself — the
command below pulls in the right one.

## Install with Composer

From the project root:

```bash
composer require drupal/tailwind_merge_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required PHP
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tailwind_merge_classes -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tailwind_merge_classes -y
```

## Verify it worked

There is no configuration and no admin page — once enabled you can immediately use
the `tw_merge()` Twig function in your templates (see the [main guide](../index.md)).
As the module's documentation puts it, just enable it and start using it in your
Twig files.
