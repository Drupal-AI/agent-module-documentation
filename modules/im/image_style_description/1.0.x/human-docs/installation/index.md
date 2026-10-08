# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.

The module also defines a permission for administering the descriptions; grant it
to the roles that build image styles (typically administrators) at **People →
Permissions** if you restrict access beyond the default.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_style_description -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_style_description -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_style_description -y
```

## Verify it worked

Go to **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`) and edit any style. You should see a new
**Description** field on the form; after you fill it in and save, the description
appears on the styles listing. See the [manual setup guide](../index.md) for
details.
