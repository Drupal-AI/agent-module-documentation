# Installation

## Requirements

- **Drupal 10.4+ or 11.1+** (`core_version_requirement: ^10.4 || ^11.1`).
- **OAuth2 Client** (`oauth2_client`) — handles the OAuth2 authentication flow.
- **Imagecache External** (`imagecache_external`) — for handling remote (Etsy)
  images.
- An **Etsy account and an Etsy developer app** (to obtain API/OAuth2 credentials).
- Recommended companions (optional): **Pathauto** and **Metatag**.

## Install with Composer

From the project root:

```bash
composer require drupal/etsy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pull in the required `oauth2_client` and
`imagecache_external` modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/etsy -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en etsy -y
```

Drupal will enable `oauth2_client` and `imagecache_external` as dependencies.

## Verify it worked

Confirm the module is enabled (**Extend**, or `drush pml | grep etsy`) and that a
user with the **Administer Etsy settings** permission can reach the Etsy API
settings to enter credentials — see [Configuration](../configuration/index.md).
