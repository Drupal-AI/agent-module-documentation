# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Field** (`field`) and **Datetime** (`datetime`) modules — Drupal enables
  them automatically as dependencies.

There are no third‑party Composer packages, PHP extensions, or JavaScript
libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/datetime_more -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datetime_more -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetime_more -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a datetime field)* → Manage form
display**. The field's **Widget** dropdown should now offer **Datelist more**.
Select it, open its gear-icon settings, and you should be able to set a minimum and
maximum year (anywhere from 0001 to 9999) and choose number-field or select-list
rendering. On the node edit form the widget should also show a **seconds** input.
