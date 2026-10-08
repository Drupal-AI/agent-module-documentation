# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No contributed-module dependencies. The formatters it extends belong to core (and
  core's Media/Responsive Image, if you use those). There are no third-party
  Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_class -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_class -y
```

That's all — there is no configuration page. The **Class** field now appears in the
settings of the Image, Responsive image, Media thumbnail and Media responsive
thumbnail formatters.

## Next step

Add a class to an image field on its *Manage display* page — see
[How to use it](../index.md#how-to-use-it) on the overview page.
