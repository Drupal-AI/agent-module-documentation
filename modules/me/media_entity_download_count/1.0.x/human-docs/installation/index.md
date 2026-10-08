# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Media Entity Download** module (`media_entity_download`) — this is a
  required dependency and provides the download link for media files. Composer
  pulls it in automatically with the command below.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_download_count -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Media Entity
Download and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_download_count -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_download_count -y
```

Media Entity Download is enabled automatically as a dependency if it is not
already on.

## Verify it worked

Go to **Configuration → Media → Media Entity Download Count Settings**
(`/admin/config/media/download/count/form/settings`) and confirm the settings form
loads. Nothing is counted yet — you still need to add a count field to a media type
and switch counting on, which is covered in
[Configuration](../configuration/index.md).
