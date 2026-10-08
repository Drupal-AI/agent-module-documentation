# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No external JavaScript or PHP libraries — the module is self‑contained.
- No other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/mtc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mtc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mtc -y
```

## Verify it worked

Go to `/admin/config/multiple_timezone_clock`. If the clock configuration form
loads and lets you add a time zone, the module is installed. Next, configure your
clocks and place the **Multiple Timezone Clock** block — see "How to use it" on the
[overview page](../index.md).
