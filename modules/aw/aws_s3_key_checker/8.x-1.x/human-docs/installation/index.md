# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- The **AWS SDK for PHP** (`aws/aws-sdk-php`), which Composer installs with the
  module.
- **AWS credentials** with read access to the bucket(s) you want to check —
  supplied either in `settings.php` or via an IAM instance role (see
  [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/aws_s3_key_checker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AWS SDK and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aws_s3_key_checker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aws_s3_key_checker -y
```

Before you can run a check, register your bucket(s) and supply AWS credentials —
see [Configuration](../configuration/index.md).
