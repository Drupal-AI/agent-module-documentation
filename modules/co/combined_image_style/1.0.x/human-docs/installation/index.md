# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- Core's **Image** module (part of standard Drupal), since this builds on the
  image‑style system.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/combined_image_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/combined_image_style -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en combined_image_style -y
```

The base module gives you the `CombinedImageStyle` API for use from code. It is a
drop‑in replacement, so your existing image styles and derivatives keep working
unchanged.

## Submodules

If you want to use combined styles from the admin UI without writing code, enable
the optional formatters submodule:

```bash
drush en combined_image_style_formatters -y
```

**Combined image style formatters** (`combined_image_style_formatters`) adds basic
field formatters for image and media (entity‑reference) fields, so you can select
the styles to combine on a field's *Manage display*. It requires the base module,
which is already present once you have installed it above.

## Verify it worked

Confirm the modules appear as enabled at **Extend** (`/admin/modules`) or with
`drush pml | grep combined_image_style`. If you enabled the formatters submodule,
edit an image or media field's **Manage display** and you should see the new
combined‑style formatter as an option.
