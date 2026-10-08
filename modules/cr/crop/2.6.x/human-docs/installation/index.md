# Installation

## Requirements

Crop API runs on **Drupal 9.3, 10, or 11** (`core_version_requirement:
^9.3 || ^10 || ^11`). It depends on two modules that ship with Drupal core and
are enabled automatically:

- **Image** (`image`) — provides image styles and image effects, which Crop
  extends with its **Crop** effect.
- **User** (`user`) — core's account module.

There are no external PHP libraries or contrib dependencies to install. Crop
also bundles one optional submodule, **Crop media entity**
(`crop_media_entity`), for wiring crops into Media entities; enable it only if
you crop Media.

Remember that Crop stores crops but does **not** provide an editing interface. To
actually crop images in the browser you also install a consuming module such as
**Image Widget Crop** (`image_widget_crop`) or **Focal Point**
(`focal_point`). Those are separate projects, installed the same way as below.

## Install with Composer

From the project root:

```bash
composer require drupal/crop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/crop -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crop -y
```

Core's `image` and `user` modules are already enabled on a standard site, so
nothing else needs turning on. Once Crop is enabled, its admin screen appears
under **Configuration → Media → Crop types** (`/admin/config/media/crop`).

## Verify it worked

Log in as an administrator and go to `/admin/config/media/crop`. You should see
the **Crop types** page with an **+ Add crop type** button. If that page loads,
the module is installed correctly. Next, head to
[Configuration](../configuration/index.md) to create your first crop type.
