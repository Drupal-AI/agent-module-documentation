# Installation

## Requirements

Symfony Mailer Office 365 needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Symfony Mailer** module (`symfony_mailer`) — the base mail system this
  transport plugs into. Although Symfony Mailer is not listed as a hard package
  dependency in this module's metadata, the transport has nothing to attach to
  without it, so install and enable it too.
- A registered application in **Microsoft Entra** (Azure AD) with a client
  secret and the appropriate mail permissions — see
  [Configuration](../configuration/index.md).

There are no additional PHP library requirements listed.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_office365 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_office365 -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer_office365 -y
```

If Symfony Mailer is not already enabled, enable it in the same step:

```bash
drush en symfony_mailer symfony_mailer_office365 -y
```

## Verify it worked

Visit `/admin/config/system/mailer/office365`. You should reach the module's
Office 365 settings and status page, ready for you to enter your Azure app
credentials. No mail will flow until you complete the steps in
[Configuration](../configuration/index.md).
