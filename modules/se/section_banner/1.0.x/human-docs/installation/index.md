# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules **Block** (`block`), **File** (`file`), **Image** (`image`), and
  **Filter** (`filter`) — Drupal enables these automatically as dependencies when
  you turn on Section Banner.

There are no third-party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/section_banner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/section_banner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en section_banner -y
```

## Verify it worked

After enabling, go to **Configuration → Content authoring → Section Banner**
(`/admin/config/content/section-banner`) and confirm the banner management screen
loads. Then continue with [Configuration](../configuration/index.md) to create a
banner and place the block. The module creates no new content types.
