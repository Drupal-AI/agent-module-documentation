# Installation

## Requirements

- **Drupal 9, 10 or 11.** Note the declared requirement is written `^9 | ^10 || ^11`
  (a single pipe before `^10`), which is not valid Composer OR syntax — confirm it
  resolves as intended for your Drupal version.
- **Facebook's PHP Business SDK** (`facebook/php-business-sdk`) — a Composer package
  the module uses to talk to Meta. Make sure it is installed (the `-W` flag below pulls
  it in as a dependency).
- A **Meta/Facebook** account with a Pixel ID and a Conversions API access token.

This project is seeking a co-maintainer and is not covered by Drupal's security
advisory policy, so review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/meta_conversions_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install
`facebook/php-business-sdk` and update any shared dependencies as needed. After
installing, confirm the SDK is present in your `vendor/` tree.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/meta_conversions_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en meta_conversions_api -y
```

## Verify it worked

Visit the module's settings form (the `meta_conversions_api.settings` route under
**Configuration**) as a user with the **Administer meta conversions api** permission.
If it loads, the module is installed. Nothing is sent to Meta until you enter the
Pixel ID and access token and — critically — wire up consent enforcement, all covered
in [Configuration](../configuration/index.md).
