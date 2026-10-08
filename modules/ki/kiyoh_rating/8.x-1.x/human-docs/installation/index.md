# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) enabled — the only dependency, and Drupal
  enables it automatically as a dependency.
- A **Kiyoh account** with a company profile, so you have a **Kiyoh hash** to
  point the widget at.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/kiyoh_rating -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/kiyoh_rating -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en kiyoh_rating -y
```

Enabling Kiyoh rating will also enable core Block if it isn't already on.

## Verify it worked

Log in as an administrator and go to **Structure → Block layout**
(`/admin/structure/block`). Click **Place block** in any region and search for
the **Kiyoh rating** block. If it appears in the list, the module is installed —
continue to [Configuration](../configuration/index.md) to place it and enter your
Kiyoh hash.
