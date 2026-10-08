# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- An **AWS S3 account** with a bucket, plus an AWS **access key** and **secret key**.
- Composer, which pulls in the two libraries the module relies on:
  `ifsnop/mysqldump-php` ^2 (creating the dump) and `aws/aws-sdk-php` ^3 (uploading to
  S3).
- For scheduled exports, the **Ultimate Cron** module works with the bundled cron job
  (regular Drupal cron also drives it).

This project is not covered by Drupal's security advisory policy. Given the handling of
dumps and credentials described on the [index](../index.md) and
[Configuration](../configuration/index.md) pages, review it carefully before using it
on production.

## Install with Composer

From the project root:

```bash
composer require drupal/s3_db_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the mysqldump and AWS SDK libraries.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/s3_db_export -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en s3_db_export -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Content authoring → DbForm**
(`/admin/config/content/DbForm`). If the AWS settings form loads, the module is
installed. Before running an export, complete the steps in
[Configuration](../configuration/index.md) — including creating the required `tmp`
directory.
