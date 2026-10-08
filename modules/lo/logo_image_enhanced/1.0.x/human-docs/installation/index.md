# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Image** module (`image`), which is enabled by default on standard
  installs. Drupal enables it automatically as a dependency if it isn't already
  on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/logo_image_enhanced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/logo_image_enhanced -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en logo_image_enhanced -y
```

## Verify it worked

Go to **Appearance → Settings** (`/admin/appearance/settings`). In the
"Logo image settings" area you should see a new **Logo Image Enhanced** fieldset
with fields for image style, alt text, title, and the loading attributes. If
it's there, the module is working — head to
[Configuration](../configuration/index.md) to set it up.
