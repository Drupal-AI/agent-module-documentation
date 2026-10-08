# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements — the button is dependency‑free vanilla JavaScript.

## Install with Composer

From the project root:

```bash
composer require drupal/back_2_top -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/back_2_top -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en back_2_top -y
```

The button is **disabled by default** — after enabling, open **Configuration → User
Interface → Back-2-Top Settings** and turn it on. See the *How to use it* section on the
[overview page](../index.md) for the settings.
