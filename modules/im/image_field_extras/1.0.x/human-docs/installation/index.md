# Installation

## Requirements

Image Field Extras is lightweight. It needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Image** module (`image`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on Image Field
  Extras.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_field_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_field_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_field_extras -y
```

That's all it takes. There is no required configuration.

## Verify it worked

Edit any content that has an image field. In the image widget you should now see a
**photo credit** and a **caption** input alongside the usual upload and alt/title
fields. Enter values, save, and view the content — the credit and caption should
render together with the image.
