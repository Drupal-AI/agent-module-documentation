# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Media** module (`media`) and **File** module (`file`) — Drupal enables
  them automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_default_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_default_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_default_image -y
```

## Verify it worked

After enabling, go to an image field's **Manage display** (**Structure → Content
types → *(type)* → Manage display**) and confirm the module's default-image
widget is available. Configure it with your fallback image, then view content
where the image is missing — the configured default should appear in place of a
broken image.
