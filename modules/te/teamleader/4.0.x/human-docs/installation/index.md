# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1** or newer.
- The `janhenkes/teamleader-php-sdk` PHP library, which the 4.0.x branch uses to
  talk to Teamleader — Composer installs it automatically with the command below.
- A **Teamleader account** with an app registered in it, so you have an OAuth2
  **client ID** and **client secret** to connect with. (You can sign up for a free
  Teamleader trial to get started.)
- Optionally, the **Key** (`key`) module if you want to store the OAuth2 client ID
  and secret as managed keys rather than plain configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/teamleader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Teamleader PHP SDK.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/teamleader -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en teamleader -y
```

To also capture Drupal Contact form submissions as Teamleader contacts, enable the
example submodule:

```bash
drush en teamleader_contact -y
```

## Grant permissions

The module provides its own permissions. Visit **People → Permissions** and grant
them to the roles that should be allowed to configure and use the integration.

## Next steps

Connect your site to Teamleader by entering your app credentials — see
[Configuration](../configuration/index.md).
