# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core **Media** (`media`) and **Media Library** (`media_library`), plus core
  **System** — Drupal enables these automatically as dependencies.
- No third‑party PHP libraries are required.

> **Note on maintenance:** LGMS is marked *minimally maintained* and is **not**
> covered by Drupal's security advisory policy. Weigh that before using it on a
> high‑exposure production site.

## Install with Composer

From the project root:

```bash
composer require drupal/lgms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Notice the **Composer package is `drupal/lgms`**, even
though the module you enable is called `lgmsmodule`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lgms -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The machine name is **`lgmsmodule`**, not `lgms`:

```bash
drush en lgmsmodule -y
```

Drupal will enable Media and Media Library at the same time if they are not
already on. There are no submodules.

## Verify it worked

1. Visit **Extend** (`/admin/modules`) and confirm **LGMS** is enabled.
2. Look for the LGMS **dashboard** link in the admin area, and confirm the
   settings form loads at `/admin/config/system/lgmsmodule`.
3. As a user with **Create guide content**, create a test guide to confirm the
   guide → page → box structure works end to end.

Next, set up who can build and view guides in
[Configuration](../configuration/index.md).
