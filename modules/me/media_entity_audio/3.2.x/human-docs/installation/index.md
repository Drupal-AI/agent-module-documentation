# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) and **Link** module (`link`), both enabled
  automatically as dependencies. (You will typically also want **Media Library** for
  the selection UI, though it is not a hard dependency of this module.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_audio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/media_entity_audio -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_audio -y
```

## Verify it worked

Go to **Structure → Media types → Add media type**
(`/admin/structure/media/add`) and confirm that **Audio Stream** appears in the
**Media source** list. Create a type using it, add a media item with an audio URL,
and view it to confirm the HTML5 player renders. See the
[overview](../index.md#how-to-use-it) for the full walkthrough. There is no other
configuration.
