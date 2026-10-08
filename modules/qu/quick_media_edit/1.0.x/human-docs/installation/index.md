# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Media** (`media`) and **Image** (`image`) modules — both are enabled
  automatically as dependencies.

There are no third‑party Composer or PHP‑library requirements. Note the project is
*not* covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/quick_media_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quick_media_edit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quick_media_edit -y
```

## Configure the image display

The module needs the media image to link to its edit form. Go to
`/admin/structure/media/manage/image/display/media_library` (**Structure → Media
types → Image → Manage display**, *Media library* view mode) and set the image to be
**linked to content**.

## Verify it worked

Edit a node that references a media image, follow the image's edit link, change and
save the image — you should be returned to the node form you started from rather than
the Media Library. Remember the module currently handles **images only**.
