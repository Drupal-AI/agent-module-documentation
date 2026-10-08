# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- No modules outside Drupal core, and no API key.
- Outbound HTTPS access from your server to the third-party feed service
  (`api.woxo.tech`), since the feed is fetched from there at display time.
- The Instagram accounts you display must have **public** profiles.

## Install with Composer

From the project root:

```bash
composer require drupal/instagram_feed_by_username -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instagram_feed_by_username -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instagram_feed_by_username -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and confirm the
**Instagram Feed By Username** field type is available to add. Add the field,
enter a public Instagram username on a piece of content, and view it to confirm
the recent posts render. There is no separate configuration page — see the
[overview](../index.md) for how the field is used.
