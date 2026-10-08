# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- An **Instagram Basic Display API access token** for the account you want to
  display. The module cannot fetch a feed without it — see the Instagram
  developer documentation for how to register an app and generate a token.
- Your server must be able to make outbound HTTPS requests to Instagram/Meta.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/instagram_posts_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instagram_posts_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instagram_posts_block -y
```

## Verify it worked

Go to **Structure → Block Layout**, click **Place block** on any region, and
search for **Instagram posts block**. If it appears in the list, the module is
installed and ready — place it and enter your Instagram access token in the
block's settings to see the feed.
