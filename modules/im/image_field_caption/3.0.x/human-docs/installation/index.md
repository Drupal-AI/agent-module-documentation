# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** field (part of standard installs) — this module extends it.
- No third-party libraries and no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/image_field_caption -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/image_field_caption -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_field_caption -y
```

There are no submodules. Enabling the module creates the database tables it uses
to store captions (`image_field_caption` and `image_field_caption_revision`);
uninstalling the module drops them again.

## Next step

Nothing changes visibly until you enable captions on a specific image field and
choose the caption formatter. Head to [Configuration](../configuration/index.md).
