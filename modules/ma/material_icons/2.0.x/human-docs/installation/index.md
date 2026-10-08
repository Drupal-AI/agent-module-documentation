# Installation

## Requirements

Material Icons is lightweight. It needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Editor** module (`editor`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on Material Icons.

There are no third‑party Composer or PHP library requirements. The icon fonts
themselves are served from Google Fonts at render time, so the site needs outbound
access to Google Fonts for icons to display.

## Install with Composer

From the project root:

```bash
composer require drupal/material_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/material_icons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en material_icons -y
```

## After enabling

1. Visit **Configuration → Content authoring → Material Icons**
   (`/admin/config/content/material_icons`) and enable the icon families you want.
2. Grant the **Use material icons** permission to any role that should be able to
   pick icons, and **Administer material icons** to those who manage the settings
   form, at **People → Permissions**.

See the [main page](../index.md) for how to add an icon field or the CKEditor
button. There are no submodules.
