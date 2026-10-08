# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Social Post** module (`social_post`, version 3.x or newer), which this
  module extends. Install and configure it first — see its
  [guide](../../../social_post/3.0.x/human-docs/index.md).
- Mastodon API credentials from your Mastodon instance (an application registered
  there).

This is an alpha release (3.0.0-alpha3); test it before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/social_post_mastodon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Social Post if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_post_mastodon -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_post_mastodon -y
```

## Verify it worked

Go to **Configuration → Social API → Social Post**
(`/admin/config/social-api/social-post`). The Mastodon integration should now
appear on that page. Connect a Mastodon account there, using credentials stored
securely, as described in the [main guide](../index.md).
