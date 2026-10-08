# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules, third-party Composer packages, or PHP libraries are required.

Install it on a **local or development** environment only — it disables CSS
aggregation site-wide and is explicitly meant to be removed before production.

## Install with Composer

From the project root:

```bash
composer require drupal/cachebuster -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cachebuster -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cachebuster -y
```

There is no configuration. From the moment it's enabled, CSS is served without
aggregation so your edits show up immediately, and an admin warning appears reminding
you to uninstall it outside development.

## Turning it off

Because the behaviour is entirely tied to the module being on, you disable it simply
by uninstalling it:

```bash
drush pmu cachebuster -y
```

Do this before promoting the site to production.
