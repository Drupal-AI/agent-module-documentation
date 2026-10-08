# Installation

## Requirements

- **Drupal 8.7.7 or newer, through Drupal 12** (`core_version_requirement:
  ^8.7.7 || ^9 || ^10 || ^11 || ^12`).
- **PHP 7.2 or newer** (`php_requirement: 7.2`).
- The **SMS Framework** module (`drupal/sms`) — a required runtime companion. This
  module only provides the gateway plugin, which is unusable without the
  framework, even though the framework isn't listed in the module's `.info.yml`.
- An **SMS.ru account** for the API ID (or login/password) you'll enter on the
  gateway.

There are no third‑party PHP library requirements — the module states it needs
Drupal core only.

## Install with Composer

Install both the module and the SMS Framework companion:

```bash
composer require drupal/smsru drupal/sms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (It's recommended to lock the version until a stable
release is out.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smsru drupal/sms -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en sms smsru -y
```

Enable the **SMS Framework** (`sms`) alongside `smsru`, since the gateway plugin
depends on it at runtime.

## Next step

Add an SMS.ru gateway and choose an authentication method — see
[Configuration](../configuration/index.md).
