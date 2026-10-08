# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — the only dependency, enabled automatically.

The module bundles the lozad.js and animate.css libraries and includes them for you,
so there is no separate library download step.

## Install with Composer

From the project root:

```bash
composer require drupal/image_lazy_loader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_lazy_loader -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_lazy_loader -y
```

## Verify it worked

Go to **Structure → *(content type)* → Manage display**, open an image field's
formatter settings, and confirm you can enable lazy loading and choose an
animation. The module settings page should also be reachable at
**Configuration → Media → Image Lazy Loader**
(`/admin/config/media/image-lazy-loader`). See
[Configuration](../configuration/index.md) for what that page controls.
