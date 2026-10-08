# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Layout Builder** (`layout_builder`) module — the only dependency, and
  Drupal enables it automatically when you turn on DROWL Admin.

There are no third‑party Composer or PHP library requirements. Note that DROWL
Admin is designed to be used **together with other `drowl_*` modules** — on its
own it has little effect.

## Install with Composer

From the project root:

```bash
composer require drupal/drowl_admin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drowl_admin -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drowl_admin -y
```

## Verify it worked

Log in as an administrator and browse the admin backend — the DROWL toolbar and
backend fixes are applied automatically, with no settings form to visit. In
practice you will notice its effect most clearly on the administration pages of
the other DROWL modules you have installed.
