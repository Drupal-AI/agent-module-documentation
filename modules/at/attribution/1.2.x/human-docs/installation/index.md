# Installation

## Requirements

- **Drupal 10.5, 11.2, or 12** (`core_version_requirement: ^10.5 || ^11.2 || ^12`).
- Core's **Field** module (`field`), enabled on standard installs.
- The **`composer/spdx-licenses`** PHP library (`^1.5`), pulled in automatically by
  Composer — it supplies the 400+ SPDX licenses you can import.

## Install with Composer

From the project root:

```bash
composer require drupal/attribution -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in `composer/spdx-licenses`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/attribution -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en attribution -y
```

On enable, the module installs ten common licenses as configuration (CC0, the
CC-BY family, GPL-2.0-or-later, All Rights Reserved, and an "Uncertain copyright
status" entry), so you have a usable license list straight away.

## Verify it worked

- Go to **Structure → Attribution licenses**
  (`/admin/structure/attribution-license`) and confirm the default licenses are
  listed.
- Go to **Structure → *(a content type)* → Manage fields → Add field** and confirm
  **Attribution** appears as a field type.
- Go to **Structure → Block layout** and confirm the **Attribution** and
  **Copyright** blocks are available to place.

Next, see [Configuration](../configuration/index.md) to curate the license list,
add an attribution field, and place the site-wide blocks.
