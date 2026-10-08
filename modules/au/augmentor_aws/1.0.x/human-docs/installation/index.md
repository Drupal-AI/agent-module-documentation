# Installation

## Requirements

- **Drupal 10.1, 11 or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The [**Augmentor**](https://www.drupal.org/project/augmentor) framework
  (`augmentor`), which this submodule plugs into.
- The **AWS SDK for PHP** (`aws/aws-sdk-php ^3.255`), pulled in automatically by
  Composer.
- AWS credentials available through the standard AWS credential chain
  (environment variables or an EC2/ECS instance role) — see below.

## Install with Composer

From the project root:

```bash
composer require drupal/augmentor_aws -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Augmentor and the
AWS SDK and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/augmentor_aws -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en augmentor_aws -y
```

Drupal enables the Augmentor dependency at the same time.

## Provide AWS credentials via the environment

This module never stores AWS credentials in Drupal. Supply them to the environment
so the AWS SDK's credential chain can find them:

- **Environment variables** — `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
  With DDEV: `ddev dotenv set .ddev/.env --aws-access-key-id=<value>` and
  `--aws-secret-access-key=<value>` (never commit `.ddev/.env`), then
  `ddev restart`. Confirm the variables are present without printing them:
  `ddev exec 'test -n "$AWS_ACCESS_KEY_ID"'` (exit status 0 means set).
- **Instance role** — on EC2/ECS, attach an IAM role and skip stored keys entirely.

Then create an augmentor using the **AWS Rekognition Detect Faces** plugin and set
its region. See [How to use it](../index.md#how-to-use-it).
