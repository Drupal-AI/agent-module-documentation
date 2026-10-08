# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core's **Image** (`image`) module.
- The **External Media** (`external_media`) contrib module.
- The **Focal Point** (`focal_point`) contrib module.

Both External Media and Focal Point must be enabled for this bridge module to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/external_media_focal_point -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
required External Media and Focal Point modules along with any shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_media_focal_point -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_media_focal_point -y
```

Enabling this module requires External Media and Focal Point to be on; enable them
first (or let Drush resolve them) if they aren't already.

## Verify it worked

Go to any content type's **Manage form display** (Structure → Content types →
*(bundle)* → Manage form display) and open the widget dropdown for an image
field. **External Media with Focal Point** should appear as an option. Selecting
and configuring it is the whole setup — see
[Configuration](../configuration/index.md).
