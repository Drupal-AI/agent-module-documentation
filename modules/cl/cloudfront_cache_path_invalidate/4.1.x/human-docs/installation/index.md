# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **AWS SDK for PHP** (`aws/aws-sdk-php` `3.*`) — pulled in automatically by
  Composer.
- An **Amazon CloudFront distribution** in front of your site, and AWS credentials
  (or an IAM role) able to call `cloudfront:CreateInvalidation` on it.

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudfront_cache_path_invalidate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AWS SDK and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cloudfront_cache_path_invalidate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudfront_cache_path_invalidate -y
```

There are no submodules. Before the module can do anything, add your AWS
credentials to `settings.php` and configure the invalidation rules — see
[Configuration](../configuration/index.md).
