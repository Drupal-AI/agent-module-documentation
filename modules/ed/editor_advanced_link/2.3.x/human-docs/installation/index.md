# Installation

## Requirements

- **Drupal 10.5 or 11.2+** (`core_version_requirement: ^10.5 || ^11.2`).
- Core's **Editor** module (`editor`) enabled — this is the module's only
  dependency, and Drupal enables it automatically when you turn on Editor Advanced
  Link. In practice you'll also be using **CKEditor 5**, which is where the extra
  link fields appear.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/editor_advanced_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/editor_advanced_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editor_advanced_link -y
```

Enabling the module makes the advanced attributes **available**, but it does not
change any editor until you switch them on for a text format. Head to
[Configuration](../configuration/index.md) to do that.

## Submodules

Editor Advanced Link ships **no submodules**. The base module is all you need.
Three optional *companion* projects it recommends — **Editor File**, **Linkit**,
and **CKEditor Entity Link** — are separate modules you can `composer require`
independently if you want richer internal‑linking or file‑linking dialogs; the
advanced attributes integrate with them automatically once present.
