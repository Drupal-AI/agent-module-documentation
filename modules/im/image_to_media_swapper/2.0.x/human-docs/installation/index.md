# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **CKEditor 5** (`ckeditor5`), **Media Library** (`media_library`), and
  **Serialization** (`serialization`) — enabled automatically as dependencies.
- [Linkit](https://www.drupal.org/project/linkit) — *recommended*. Required for
  converting file **links**; without it, only image conversion works.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_to_media_swapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add Linkit at the same time:

```bash
composer require drupal/image_to_media_swapper drupal/linkit -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_to_media_swapper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_to_media_swapper -y
```

## Verify it worked

Confirm the module is enabled (**Extend**, or `drush pm:list | grep
image_to_media_swapper`), then check that the **security settings** form appears
at **Configuration → Media → File to Media Swapper**
(`/admin/config/media/file-to-media-swapper/settings`). Next, follow
[Configuration](../configuration/index.md) to add the CKEditor button and allow
`<drupal-media>` in a text format.

> **Before any bulk conversion, take a database backup** — the batch tool rewrites
> the markup stored in your content fields.
