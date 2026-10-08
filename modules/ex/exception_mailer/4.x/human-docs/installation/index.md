# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working outbound **mail** setup on your site (Drupal's mail system must be able to
  send email), since the module's whole job is to send notifications.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/exception_mailer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exception_mailer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exception_mailer -y
```

## Verify it worked

Log in as an administrator and open **Administration → Development → Exception mailer
config** (`/admin/config/development/exception_mailer`). If the settings form loads, the
module is installed. Continue to [Configuration](../configuration/index.md) to turn on
emailing and choose recipients — and confirm your site can actually send mail before
relying on it.
