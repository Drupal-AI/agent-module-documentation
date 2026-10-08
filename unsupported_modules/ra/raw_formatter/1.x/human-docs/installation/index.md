# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which core enables by default.
- The **Metatag** module (`metatag`) — this is listed as a dependency and will
  be pulled in with Composer.

There are no additional PHP library requirements.

> **Before you install:** this project is marked **Unsupported** on drupal.org
> and its security advisory coverage has been **revoked**. Read the security note
> on the [overview page](../index.md) and consider an actively maintained
> alternative before adding it to a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/raw_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/raw_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en raw_formatter -y
```

## Verify it worked

Go to the **Manage display** tab of a content type (or other fieldable entity)
and confirm the raw formatter now appears as a **Format** option for your
fields. Selecting it and saving is all that is required — there is no settings
form to fill in.
