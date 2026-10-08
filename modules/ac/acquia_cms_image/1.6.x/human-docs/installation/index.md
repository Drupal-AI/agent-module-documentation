# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Acquia CMS Common** (`acquia_cms_common`) — the shared Acquia CMS layer.
- Core **Media** (`media`), **Media Library** (`media_library`), and **Image**
  (`image`).
- **IMCE** (`imce`) — file browser.
- **Field Group** (`field_group`) — groups fields on the media form.
- **Focal Point** (`focal_point`) — focal-point cropping for images.

Enabling Image pulls in the common layer and its dependencies, so expect the
broader Acquia CMS set to come along with it.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`acquia_cms_common`, `focal_point`, `imce`, `field_group`, and the other shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_image -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_image -y
```

Drush enables the dependencies automatically. Once it finishes, the **Image**
media type is available under **Content → Media → Add media**. There is no
required configuration.
