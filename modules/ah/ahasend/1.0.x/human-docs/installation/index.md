# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Mail System** module (`mailsystem`) — this is a hard dependency, since
  AhaSend works as a Mail System plugin. Composer will pull it in for you.
- An **AhaSend account and API credential** (from ahasend.com). You do not need it
  to install the module, but no mail will be delivered through AhaSend until it is
  configured.

There are no third-party PHP libraries to install via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/ahasend -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Mail System — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ahasend -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ahasend -y
```

Enabling AhaSend also enables Mail System if it is not already on.

## Next step

Store your AhaSend credential securely, grant the permission, and point Mail System
at AhaSend — continue to [Configuration](../configuration/index.md).
