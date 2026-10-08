# Installation

## Requirements

- **Drupal 10.3 or newer** (`core_version_requirement: ^10.3 || ^11`).
- The **Symfony Messenger** (`sm`) module, which this provides a transport for.
- A reachable, **trusted and access-controlled Redis** server — your message
  payloads pass through it.
- The `symfony/redis-messenger` library, managed by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/sm_transport_redis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`symfony/redis-messenger` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sm_transport_redis -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sm_transport_redis -y
```

Note this module is **not covered by the security advisory policy**.

## What next

Configure a Symfony Messenger transport to use Redis, pointing it at a trusted,
access-controlled Redis instance. See Symfony's documentation for the Redis
transport for the connection and option details.
