# Installation

## Requirements

Backup and Migrate: AWS S3 is an add-on for Backup & Migrate. It needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Backup and Migrate** (`drupal/backup_migrate ^5.0`), enabled.
- The **Key** module (`drupal/key ^1.15`), enabled — used to hold your AWS credentials so this
  module never stores them itself.
- The **`aws/aws-sdk-php`** library (`^3.2`) — a Composer package, pulled in automatically.
- An **S3 bucket** (on AWS, or an S3-compatible service such as MinIO / Wasabi / DigitalOcean
  Spaces) and a set of credentials with access to it. Least-privilege IAM credentials scoped to
  just the backup bucket are recommended.

The optional **Key AWS** module (`key_aws`) is supported if you'd rather use a single AWS
credentials-file key instead of separate access/secret keys.

## Install with Composer

From the project root:

```bash
composer require drupal/backup_migrate_aws_s3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Backup & Migrate, the Key
module, and the `aws/aws-sdk-php` library, and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/backup_migrate_aws_s3 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en backup_migrate_aws_s3 -y
```

This enables Backup & Migrate and Key as dependencies at the same time. If you want to use a
single AWS credentials-file key, also enable Key AWS:

```bash
drush en key_aws -y
```

Once enabled, "AWS S3" is available as a destination type inside Backup & Migrate. There's no
configuration step here — head to [Configuration](../configuration/index.md) to set up your
credential keys and add the destination.

There are no submodules in this project.
