# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Digital Signage Framework** module
  (`digital_signage_framework:digital_signage_framework`) — this owns the device
  entities and scheduling, and signageOS is a connector on top of it. Install it
  first (or let Composer pull it in).
- A **signageOS account** and API credentials. The integration is maintained by
  bitegra Solutions, an official signageOS partner; contact them to obtain access.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/signageos -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Digital Signage Framework if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/signageos -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en signageos -y
```

Drush enables the Digital Signage Framework at the same time if it is not already
on.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → Digital
Signage Framework → signageOS**
(`/admin/config/services/digital_signage_framework/signageos`). If the connection
settings form loads, the module is installed. Next, enter your credentials — see
[Configuration](../configuration/index.md).
