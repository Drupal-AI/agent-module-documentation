# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[AI module](https://www.drupal.org/project/ai)** (`ai`, `^1.1.0-beta1`) —
  this provider is a plugin for it.
- The **[Key module](https://www.drupal.org/project/key)** (`key`, `^1.18`) to
  hold AWS credentials securely.
- The **[AWS module](https://www.drupal.org/project/aws)** (`aws`).
- The **`aws/aws-sdk-php`** PHP library (`^3.316`) — Composer installs this for
  you.
- An **AWS account** with Bedrock enabled in your chosen region, and an IAM
  identity permitted to invoke the models you want (for example the
  `bedrock:InvokeModel` action).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_aws_bedrock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI, Key and
AWS modules plus the AWS SDK for PHP.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_aws_bedrock -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_aws_bedrock -y
```

Enabling it also enables the AI, Key and AWS modules if they are not on yet. The
module ships no submodules.

Continue to [Configuration](../configuration/index.md) to set the region and
supply AWS credentials.
