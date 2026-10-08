# Installation

## Requirements

Page View Counter is lightweight and relies only on Drupal core:

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Block** (`block`), **Field** (`field`) and **Link** (`link`) modules —
  Drupal enables these automatically as dependencies when you turn on the module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/page_view_counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_view_counter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_view_counter -y
```

## Verify it worked

Log in as an administrator and go to **Content → Page View Counters** — you should
see the counter dashboard (empty until pages start being viewed). The next step is to
place the **Counter block** and tune its options, described in
[Configuration](../configuration/index.md).
