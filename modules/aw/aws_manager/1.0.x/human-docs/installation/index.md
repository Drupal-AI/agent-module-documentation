# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- An **AWS account** and credentials — ideally an IAM role, or an access key /
  secret supplied through environment variables (never committed to config).

There are no other module dependencies listed.

## Install with Composer

From the project root:

```bash
composer require drupal/aws_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed (AWS Manager uses the AWS SDK for PHP).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aws_manager -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aws_manager -y
```

## After enabling

- Restrict the **`access aws manager`** permission to trusted roles only.
- Set up your AWS credentials securely — an IAM role, or environment variables —
  as described in [How to use it](../index.md#handling-aws-credentials-securely) on
  the overview page. Never commit AWS keys.
