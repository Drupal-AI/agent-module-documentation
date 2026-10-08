# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`).
- The contrib **Field Permissions** module (`field_permissions`) — this is what
  Image Field Permissions extends. You'll also want the core **Field UI** module
  enabled so you can reach a field's settings.

Composer pulls in Field Permissions automatically when you require this module.

## Install with Composer

From the project root:

```bash
composer require drupal/image_field_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Field Permissions
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_field_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_field_permissions -y
```

This enables Field Permissions as a dependency too. If Field UI isn't already on,
enable it as well:

```bash
drush en field_ui -y
```

## Verify it worked

Edit an image field at **Structure → *(your content type)* → Manage fields → *(image
field)***. Under the field's visibility and permissions settings you should now be
able to choose **Custom permissions** and see image‑specific options for the file,
alt and title. See [Configuration](../configuration/index.md) for how to set them
up.
