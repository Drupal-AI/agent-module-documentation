# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Image** module (`image`) and **Text** module (`text`), which Drupal
  enables automatically as dependencies.
- No third-party Composer packages or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/supported_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/supported_image -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en supported_image -y
```

Enabling the module makes the **Supported image** field type available. It does not
change any existing fields or touch core's Image field type.

## Verify it worked

Go to **Manage fields** on any content type and click **Add field**. With the
module enabled, **Supported image** should appear in the list of available field
types.

## Related modules

To extend how a Supported Image field displays, you can add these separate projects:

- **Supported Image Delta Formatter** — show specific values (deltas) of a
  multi-value field.
- **Supported Image BaguetteBox Formatter** — open images in a baguetteBox.js
  lightbox.
- **Supported Image Swiper Formatter** — render the images as a Swiper carousel.

> **Note:** This release is a beta (1.0.0-beta1) and is not covered by Drupal's
> security advisory policy. Review it before relying on it in production.
