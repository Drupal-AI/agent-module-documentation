# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third‑party Composer or PHP library requirements — the JavaScript
widget ships with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/open_accessibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/open_accessibility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en open_accessibility -y
```

## Configure and place the widget

The module does its work through a settings form and a block:

1. Grant the **Configure Open Accessibility** permission to the appropriate roles
   at **People → Permissions** (`/admin/people/permissions`).
2. Visit **Configuration → User interface → Open Accessibility**
   (`/admin/config/user-interface/open-accessibility`) and choose which
   accessibility controls the toolbar should offer and how it looks.
3. Place the **Open Accessibility** block into a region at **Structure → Block
   layout** (`/admin/structure/block`) so the floating widget shows on the front
   end.

## Verify it worked

Load a front‑end page (as an anonymous visitor is a good test) and look for the
floating accessibility toolbar. Open it and try a control — for example toggling
higher contrast or larger text — to confirm the widget is working.

Remember: the widget is a supplement, not a substitute for building an accessible
site. See the [overview](../index.md) for why that distinction matters.
