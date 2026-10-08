# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

No additional Drupal modules are required. By default the AOS front-end library is
loaded from a public **CDN** — if you prefer to self-host it (recommended for
privacy-sensitive sites or offline development), download AOS from its repository
and override the library's JS/CSS paths in your theme or a custom module.

## Install with Composer

From the project root:

```bash
composer require drupal/effect_aos_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/effect_aos_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en effect_aos_field -y
```

## Verify it worked

Go to a content type's **Manage fields** and add a field. If **AOS Animation
Effects** appears in the field-type list, installation succeeded. Add the field,
allow a sibling field to be animated on **Manage form display**, then edit a piece
of content, apply an effect, save, and view the page — the target field should
animate as it scrolls into view.
