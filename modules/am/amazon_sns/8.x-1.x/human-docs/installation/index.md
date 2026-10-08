# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The **AWS SDK for PHP**, which provides the `MessageValidator` used to verify
  SNS signatures. Composer pulls this in with the module — keep it up to date,
  since signature validation depends on it.
- An **AWS account** with an SNS topic you can subscribe to your site's endpoint.

## Install with Composer

From the project root:

```bash
composer require drupal/amazon_sns -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the AWS SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/amazon_sns -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amazon_sns -y
```

Once enabled, the endpoint at `/_amazon-sns/notify` is live and ready to receive
validated SNS notifications. Configure the topic and subscription on the AWS
side, then write code to react to the dispatched Drupal events (see the
[overview](../index.md)).
