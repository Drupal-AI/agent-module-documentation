# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **SMS Framework** module (`sms`, project `smsframework`) enabled — this is
  the framework BulkGate SMS plugs into.
- A **BulkGate account** with an Application ID and Application token (created in
  your BulkGate portal).

## Install with Composer

From the project root:

```bash
composer require drupal/bulkgate_sms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer pulls in the BulkGate PHP SDK that the module
uses to talk to the API.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bulkgate_sms -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable BulkGate SMS together with SMS Framework:

```bash
drush en sms bulkgate_sms -y
```

## Next step

With both modules enabled, go on to [Configuration](../configuration/index.md) to
add the BulkGate gateway and enter your credentials.
