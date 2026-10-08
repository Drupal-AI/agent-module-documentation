# Installation

## Requirements

- **Drupal 8.9, 9, or 10** (`core_version_requirement: ^8.9 || ^9 || ^10`).
- Core's **Telephone** module (`telephone`) and **Field UI** (`field_ui`), plus the
  **Field** module — the telephone and field dependencies are enabled automatically.
- The **libphonenumber‑php** library (the PHP port of Google's libphonenumber),
  which is pulled in by Composer. Because of this, the module **must be installed
  via Composer** — the tarball downloads on drupal.org are provided for reference
  only and will not include the required library.

## Install with Composer

If your project is not already set up to fetch Drupal modules from drupal.org, add
the Drupal.org Composer repository once:

```bash
composer config repositories.drupal composer https://packages.drupal.org/8
```

Then require the module:

```bash
composer require drupal/telephone_type -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and Composer pulls in the libphonenumber library for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telephone_type -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telephone_type -y
```

## Verify it worked

Go to a content type's **Manage fields** screen and add a field. The **Telephone
Type** field type should appear in the list. Add it, and on **Manage form display**
the widget should offer both a number input and a type selector (mobile, home,
work, fax, etc.).
