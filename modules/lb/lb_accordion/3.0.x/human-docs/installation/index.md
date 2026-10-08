# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Y Layout Builder** module (`y_lb`) — this module is designed to be used with
  the [YMCA Website Services distribution](https://www.drupal.org/project/openy).

## Important: this module is part of a distribution

Y Layout Builder - Accordion is meant to be used **inside the YMCA's Website
Services distribution**, and it depends on `y_lb`. That dependency matters for
installation:

The current Y Layout Builder releases (3.x, 4.x, 5.x) live in the **YMCA's own
Composer repository**, not on Packagist. If you try to require this module on an
ordinary project without adding that repository, Composer will only find the old
`y_lb` stub published on Packagist (version 0.1 from 2022, declaring
`core_version_requirement: ^8 || ^9`), and enabling the module then fails with
*"Its dependency module 'y_lb' is incompatible with this version of Drupal core."*

**So, before requiring anything in this family, add the YMCA Composer repository**
(or, more simply, build your site from the YMCA Website Services distribution, which
already includes it). Follow the distribution's own getting‑started documentation
for the exact repository configuration.

## Install with Composer

Once the YMCA Composer repository is configured (or you are working inside the
distribution), from the project root:

```bash
composer require drupal/lb_accordion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `y_lb` and any
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lb_accordion -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_accordion -y
```

## Verify it worked

With the distribution and `y_lb` correctly in place, the **accordion** block type
should be available to add through the Y Layout Builder page‑building interface. If
enabling fails with a `y_lb` core‑incompatibility message, revisit the dependency
note above — the YMCA Composer repository has almost certainly not been added.
