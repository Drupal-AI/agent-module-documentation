# Installation

## Requirements

Responsive image class needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Responsive Image** module (`responsive_image`) enabled — this is a
  hard dependency and Drupal enables it automatically.
- Optionally, the [Focal Point](https://www.drupal.org/project/focal_point)
  module. It is **not required**: the focal‑point integration is a soft
  dependency, so the formatter works without it (falling back to
  `center center`) and lights up the crop‑aware positioning when Focal Point is
  present.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_image_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_image_class -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_image_class -y
```

To add the optional Focal Point integration:

```bash
composer require drupal/focal_point -W
drush en focal_point -y
```

## Verify it worked

Edit the **Manage display** of a bundle with an image field. The field's
**Format** dropdown should now include **Responsive image class**. Select it,
add a test class in the settings, save, and inspect the rendered page — the
`<img>` element should carry the class you entered.
