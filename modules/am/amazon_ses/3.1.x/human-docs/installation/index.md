# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The **[AWS](https://www.drupal.org/project/aws)** module (`drupal/aws ^2.0`) —
  a required dependency that owns your AWS credentials and region. Composer
  installs it for you and Drupal enables it as a dependency.
- The **AWS SDK for PHP** (`aws/aws-sdk-php ^3.54`), installed automatically by
  Composer.
- An **AWS account with SES access**, and (for production sending) your SES
  account moved out of the sandbox so it can send to unverified recipients.
- *Optional but recommended:*
  [Mail System](https://www.drupal.org/project/mailsystem)
  (`drupal/mailsystem`) — lets you route only specific modules' mail through SES
  rather than switching the whole site at once.

## Install with Composer

Because this module pulls in the AWS SDK, always install it with Composer:

```bash
composer require drupal/amazon_ses -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AWS module,
the AWS SDK, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/amazon_ses -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amazon_ses -y
```

Or enable **Amazon SES** from **Extend** (`/admin/modules`). The AWS module is
enabled at the same time if it is not already on.

There are no submodules.

## After enabling

Until you set a From address, the site **Status report** will show a
configuration error — that is expected. Continue to
[Configuration](../configuration/index.md) to connect your AWS credentials,
verify a sending identity, set the From address, and select SES as your mailer.

> **Upgrading from an older release?** Versions before 3.x stored AWS
> credentials in this module's own config. Update hooks move them into the AWS
> module's profile automatically, so run database updates after upgrading:
> `drush updatedb -y`.
