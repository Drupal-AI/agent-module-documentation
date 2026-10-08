# Installation

## Requirements

Media Inline Frame has a few hard requirements:

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.2 or newer**.
- Core's **Media** module (`media`), enabled.
- The contributed **Iframe** field module (`drupal/iframe`, `^1 || ^2 || ^3`) — this
  supplies the `iframe` field type that the media source stores its URL in. Composer
  pulls it in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/media_iframe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required **Iframe**
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_iframe -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_iframe -y
```

This also enables the **Iframe** and **Media** modules if they aren't already on
(they are listed as dependencies). Or enable **Media Inline Frame** from **Extend**
(`/admin/modules`).

There are no submodules.

## Next steps

The module has no configuration form. To start using it, create a media type that uses
the **Inline frame** source — see [How to use it](../index.md#how-to-use-it) on the
overview page. Once the media type exists, editors can create iframe media entities and
reuse them across the site.
