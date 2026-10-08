# Installation

## Requirements

jQuery MiniColors is a field widget with one external JavaScript dependency. It
needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The external **jQuery MiniColors** JavaScript library, **version 2.2.4** —
  installed into your site's `libraries` directory (see below). This is not a
  Composer package by default; you place the files yourself.

There are no other module dependencies and no PHP library requirements.

## Install the module with Composer

From the project root:

```bash
composer require drupal/jquery_minicolors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_minicolors -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the jQuery MiniColors JavaScript library

The picker won't work until the external library is present. Download **jQuery
MiniColors v2.2.4** and place it so that these two files exist:

```
/libraries/jquery-minicolors/jquery.minicolors.min.js
/libraries/jquery-minicolors/jquery.minicolors.css
```

The `/libraries` directory sits at your Drupal web root (next to `core`,
`modules`, and `themes`). One common way to fetch it:

```bash
# from the web root
mkdir -p libraries/jquery-minicolors
cd libraries/jquery-minicolors
# download jquery.minicolors.min.js and jquery.minicolors.css (v2.2.4) into this folder
```

The module ships a status check: if the files are missing, an error — *"jQuery
Minicolors Library — Not Installed"* — appears on **Reports → Status report**
(`/admin/reports/status`). Until the library is in place the field will still store
and edit a plain string, but the color picker itself won't initialise.

## Enable the module

```bash
drush en jquery_minicolors -y
```

Once enabled (and with the library installed), the **jQuery MiniColors** widget
becomes available on **Text (plain)** fields — assign it on a bundle's **Manage form
display** page, as described on the module's
[overview page](../index.md#how-to-use-it).

## Verify it worked

Visit **Reports → Status report** and confirm there's no "jQuery Minicolors Library
— Not Installed" error. Then open an entity form where you've assigned the widget —
the color field should show the MiniColors picker.
