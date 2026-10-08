# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/social_media_platforms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_media_platforms -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_media_platforms -y
```

## Verify it worked

Go to **Configuration → Web services → Social Media Platforms**
(`/admin/config/services/social-media-platforms`) and confirm the settings form
opens. Enter at least one profile URL, save, then place the block from
**Structure → Block layout** to see the icon row on your site. See
[Configuration](../configuration/index.md) for the details.
