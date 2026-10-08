# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field**, **Image**, and **File** modules (`field`, `image`, `file`) — all
  part of core and enabled automatically as dependencies. Image and File are needed
  because the thumbnail formatter downloads and manages thumbnail image files.
- Outbound HTTP access from your server to YouTube (`img.youtube.com`) so the
  thumbnail formatter can fetch images.

There are no third-party Composer or PHP library requirements.

> **Release note:** the 3.0.x branch is a **beta** (`3.0.0-beta1`). Review it before
> using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/youtube -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/youtube -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en youtube -y
```

There are no submodules. Once enabled, a **YouTube video** field type becomes
available in the field UI, and a global settings form appears under
**Configuration → Media → YouTube Field**.

## Next steps

Enabling the module doesn't add any fields for you — you attach a YouTube field to a
content type and choose how it displays. See [Configuration](../configuration/index.md).
