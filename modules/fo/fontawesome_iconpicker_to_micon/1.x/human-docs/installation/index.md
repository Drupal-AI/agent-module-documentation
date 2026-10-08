# Installation

## Requirements

Fontawesome Iconpicker to Micon Converter needs:

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- The **FontAwesome Iconpicker** module (`fontawesome_iconpicker`) — the source of
  the fields being converted.
- The **Micon** module (`micon`) — the destination icon system.

Both are required dependencies. There are no third-party PHP library requirements.

> **Note on security coverage.** This module is not covered by Drupal's security
> advisory policy. It is a developer utility — treat it accordingly, and remove it
> once the conversion is done.

## Before you start: take a backup

This module **changes field types on your site**. Before running it:

- Back up your database and your exported configuration.
- Plan to run it on a copy or in a maintenance window first, and review the
  results before doing it on production.

## Install with Composer

From the project root:

```bash
composer require drupal/fontawesome_iconpicker_to_micon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Micon,
FontAwesome Iconpicker, and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fontawesome_iconpicker_to_micon -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fontawesome_iconpicker_to_micon -y
```

## Run the conversion (once)

1. Grant yourself the **`convert fontawesome iconpicker to micon fields`**
   permission at **People → Permissions** (`/admin/people/permissions`).
2. Trigger the conversion action. It converts every FontAwesome Iconpicker field
   to a Micon Symbol field across the site, preserving the stored icon values.

## Verify it worked and clean up

1. Review the configuration changes carefully — for example with
   `drush config:export --diff` — to confirm the field types changed as expected
   and the icon values are intact.
2. Check a few pieces of content to confirm the icons still display, now via
   Micon.
3. Commit the configuration changes.
4. Once satisfied, **uninstall this utility module** — its job is done and it is
   not meant to stay enabled long-term.
