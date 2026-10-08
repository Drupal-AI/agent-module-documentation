# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Filter** module (`filter`) enabled — Drupal enables it automatically as
  a dependency. In particular you need the core **"Limit allowed HTML tags and
  correct faulty HTML"** filter, which this module extends.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filter_html_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filter_html_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filter_html_plus -y
```

Enabling the module does not change any content on its own — it just teaches the
core allowed-HTML filter to understand the `<*>` wildcard syntax.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and configure a format that uses the **Limit
allowed HTML tags** filter. Add a wildcard entry such as `<* class>` to the
**Allowed HTML tags** field and save. Then edit content in that format that uses a
`class` attribute — the attribute should now survive instead of being stripped.
See the [main guide](../index.md#how-to-use-it) for the full walkthrough and the
important security note.
