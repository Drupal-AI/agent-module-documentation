# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **JSON:API** module (`jsonapi`) enabled.
- Core's **Image** module (`image`) enabled.

Drupal pulls both dependencies in automatically when you enable this module. There
are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_image_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_image_styles -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_image_styles -y
```

That's all it takes. The `image_style_uri` field is added to every File entity
immediately, and image files start carrying their style URLs in JSON:API output.
No submodules ship with this project.

## Verify it worked

Request any image file through JSON:API (for example include `field_image` on a
node request) and confirm the included `file--file` resource now has an
`image_style_uri` attribute listing your image styles and their URLs.
