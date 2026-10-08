# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`) — the filter box is added to the admin
  toolbar's tray.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/navbar_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/navbar_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en navbar_filter -y
```

## Verify it worked

Switch the admin toolbar tray to its **vertical** orientation (use the toolbar's
orientation toggle). A filter text box should appear at the top of the tray — type
in it and confirm the menu items filter as you type. Remember the box only shows
when the toolbar is displayed vertically.
