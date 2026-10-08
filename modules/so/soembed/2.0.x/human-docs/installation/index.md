# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Media** module (`media`), which Drupal enables as a dependency.
- No third-party Composer or PHP library requirements beyond core.

This is a beta release (8.x-2.0-beta14); test it before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/soembed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/soembed -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en soembed -y
```

## Verify it worked

Enabling the module does not change any rendering on its own — you have to switch
the filter on for a text format. Go to **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`), edit a format, and
confirm the oEmbed filter appears in the list of available filters. Enable it (see
[Configuration](../configuration/index.md)), then paste a supported link on its own
line in a piece of content using that format and confirm it renders as an embed.
