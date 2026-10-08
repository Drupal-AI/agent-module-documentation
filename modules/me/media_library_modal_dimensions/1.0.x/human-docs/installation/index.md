# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Media Library** module enabled (Drupal enables it automatically as a
  dependency).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_modal_dimensions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_modal_dimensions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_modal_dimensions -y
```

No additional configuration step is required after enabling — the new **width** and
**height** settings appear automatically on every Media Library widget.

## Verify it worked

Go to a content type's **Manage form display**, click the **gear icon** on a field
that uses the **Media library** widget, and confirm you now see **Media Library
dialog width** and **Media Library dialog height** fields. Set one (for example
`95%`), save, and open that field's media picker to see the resized modal.
