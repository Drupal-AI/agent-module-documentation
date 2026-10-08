# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).

On Drupal 8 and later the JavaScript libraries the module needs are bundled with
it, so there is nothing extra to download — the older Drupal 7 instructions about
fetching Sisyphus and jStorage by hand do **not** apply here. There are no
third‑party Composer or PHP library requirements. Note the module has no
security‑advisory coverage.

## Install with Composer

From the project root:

```bash
composer require drupal/form_save_state -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_save_state -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_save_state -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → User interface → Form Save
State** (`/admin/config/user-interface/form-save-state`). If you can see the list
of form IDs to enable autosave for, the module is installed. Nothing is protected
until you choose forms — see [Configuration](../configuration/index.md).
