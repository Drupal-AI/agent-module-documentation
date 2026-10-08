# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Media** module (`media`).

The formatter builds responsive thumbnail URLs, so you will also want core's
**Responsive Image** module enabled and at least one **responsive image style**
configured (at **Configuration → Media → Responsive image styles**) to select in
the formatter settings.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_responsive_thumbnail_url_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_responsive_thumbnail_url_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_responsive_thumbnail_url_formatter -y
```

## Verify it worked

Go to a content type that has a media-reference field, open its **Manage display**
tab, and confirm **Responsive thumbnail url** appears in the format dropdown for
that field. Selecting it and choosing a responsive image style should make the
field output a thumbnail URL. The rest of the setup is described in
[How to use it](../index.md#how-to-use-it).
