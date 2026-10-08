# Installation

## Requirements

- **Drupal 11.3 or newer, or Drupal 12** (`core_version_requirement: ^11.3 | ^12`).
- Core's **Media Library** module enabled (Drupal enables it automatically as a
  dependency).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_texts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_texts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_texts -y
```

## Verify it worked

Open the **Manage form display** for an entity that has a media (entity‑reference to
media) field, confirm the field uses the **Media library** widget, click the field's
gear icon, change one of the texts — for example the **"Add media"** button — and save.
Then open that field on a content edit form and confirm your new wording appears on the
widget.
