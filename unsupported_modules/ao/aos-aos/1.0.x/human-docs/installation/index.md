<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules and no third-party PHP libraries are required. The AOS
  JavaScript library ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/aos-aos -W
```

Note the package name is **`drupal/aos-aos`** even though the module you enable is
`aos`. The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aos-aos -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

The machine name is **`aos`**, not `aos-aos`:

```bash
drush en aos -y
```

After enabling, clear caches (`drush cr`) so the library attaches. There is no
required configuration — apply AOS animation attributes to your markup as
described in the [main guide](../index.md).
