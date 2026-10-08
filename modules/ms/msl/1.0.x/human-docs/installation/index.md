# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- **Drush** — MSL is a set of Drush commands, so Drush must be installed and
  runnable. This is the only real dependency.
- A **multisite** install is the intended context, though the module will enable
  on any site.

There are no PHP extension or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/msl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/msl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> **Tip:** Install MSL on your **main project site**. If you install it only on a
> secondary site you will have to pass `--uri` to reach it — which defeats the
> point of the module.

## Enable the module

```bash
drush en msl -y
```

## Verify it worked

Run the wrapped command with no arguments to confirm the Drush command is
registered:

```bash
drush msl
```

You should be prompted to choose a target site (once you have registered some — see
[Configuration](../configuration/index.md)). You can also visit
`/admin/config/msl-configuration` in the browser to confirm the site‑list form
loads.
