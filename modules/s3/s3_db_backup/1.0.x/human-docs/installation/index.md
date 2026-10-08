# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- The **Key** module and the **Key AWS** provider (`key_aws`) — required for storing
  your AWS access and secret keys securely. `key_aws` is a declared dependency and
  will be pulled in.
- An **AWS S3 account** with a bucket, plus an AWS **access key** and **secret key**
  (if you intend to upload to S3 rather than only store locally).
- Composer, which pulls in the two libraries the module relies on:
  `ifsnop/mysqldump-php` (creating the dump) and `aws/aws-sdk-php` (uploading to S3).

## Install with Composer

From the project root:

```bash
composer require drupal/s3_db_backup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Key AWS module and the mysqldump/AWS SDK
libraries.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/s3_db_backup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en s3_db_backup -y
```

This also enables the **Key** and **Key AWS** modules if they weren't already on.

## Verify it worked

Log in as an administrator (with the **`administer s3_db_backup`** permission) and open
**Configuration → S3 DB Backup → Settings**
(`/admin/config/s3-db-backup/settings`). If the settings form loads, the module is
installed. Next, follow [Configuration](../configuration/index.md) to store your AWS
credentials and point the module at your bucket before running your first backup.
