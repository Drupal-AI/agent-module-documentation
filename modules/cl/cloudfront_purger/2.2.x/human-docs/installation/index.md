# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Purge** module (`drupal/purge` `^3.2`) — the cache-invalidation framework
  this plugs into.
- The **AWS SDK for PHP** (`aws/aws-sdk-php` `^3.0`) — used to call CloudFront.
  Composer installs it automatically.
- Suggested: **Purge Queuer URL** (`drupal/purge_queuer_url`) to collect URLs to
  purge automatically, and **Purge UI** (`purge_ui`) to configure the purger in the
  admin interface.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudfront_purger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Purge and the AWS
SDK and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudfront_purger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudfront_purger -y
```

Purge is enabled automatically as a dependency. To also configure purgers in the
UI, enable Purge's UI submodule:

```bash
drush en purge_ui -y
```

## Optional submodule: cache-tag invalidation

The base module invalidates **paths**, not cache **tags**. If you want tag-based
invalidation, enable the bundled submodule:

```bash
drush en cloudfront_purger_tags -y
```

## Verify it worked

The purger doesn't add its own admin page. Confirm it's available to Purge:

```bash
drush p:purger-lsa        # 'cloudfront' should appear in the list of available purgers
```

Then configure it (distribution ID, AWS auth, enable real purging) and register it
with Purge as described in [Configuration](../configuration/index.md).
