# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11**
  (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Media** module, using its **oEmbed** field formatter for remote video.
  The module builds on core Media's oEmbed rendering (it is used at runtime even
  though it isn't listed as a hard dependency in the info file), so you need
  Media enabled and a remote‑video media type set up.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_oembed_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_oembed_control -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_oembed_control -y
```

Once enabled, the two new options appear on any field that uses the core oEmbed
formatter — see [Configuration](../configuration/index.md).

## Submodules

None — Media oEmbed Control ships as a single module.
