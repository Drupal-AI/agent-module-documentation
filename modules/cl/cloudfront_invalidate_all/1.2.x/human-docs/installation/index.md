# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal modules are required.
- An **AWS CloudFront distribution**, and an environment that already provides AWS
  credentials — either through the **AWS metadata service** (an EC2/ECS IAM role)
  or **environment variables**. The module does not accept AWS keys through its
  own UI.

> **This module is obsolete.** For new work the maintainer recommends the **Purge**
> module with the `cloudfront_purger:^2.2` module instead, now that CloudFront
> supports cache‑based invalidation. Use this module only for a small, simple site
> where a wildcard "clear everything" is acceptable.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudfront_invalidate_all -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudfront_invalidate_all -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudfront_invalidate_all -y
```

## Verify it worked

Confirm the module is active with
`drush pm:list --status=enabled | grep cloudfront_invalidate_all`. Nothing is
invalidated until you set the distribution ID and your environment supplies AWS
credentials — see [Configuration](../configuration/index.md).
