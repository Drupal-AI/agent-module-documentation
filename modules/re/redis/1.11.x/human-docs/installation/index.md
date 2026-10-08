# Installation

Installing Redis for Drupal has **three parts**, and all three must be in place
before the cache actually runs on Redis:

1. A running **Redis server** for Drupal to connect to.
2. A **PHP Redis client** so PHP can talk to that server.
3. The **`drupal/redis` module** itself, installed and enabled.

This page covers getting all three in place. The actual connection settings are
described on the [Configuration](../configuration/index.md) page.

## Requirements

- **Drupal** 9.3, 10, or 11 (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 7.1** or newer.
- A **Redis server** you can reach from the web server (locally or over the
  network).
- A **PHP Redis client** — one of:
  - **PhpRedis** — the `redis` PHP C extension (`ext-redis`, `^4.0` or `^5.0`).
    This is the fastest option and the usual recommendation.
  - **Relay** — the `relay` PHP extension (`ext-relay`, `^0.5` or `^1.0`).
  - **Predis** — a pure-PHP client library (`predis/predis`, `^1.1` or `^2.0`),
    installed with Composer. Use this when you cannot install a PHP extension.

You need **at least one** of these clients. Without a running server *and* a
client, the module installs fine but the report page will show
*Not connected*.

## Install the module with Composer

From the project root:

```bash
composer require drupal/redis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies
as needed.

If you are using the **Predis** client (rather than a PHP extension), require it
as well:

```bash
composer require predis/predis
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/redis -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV can also
> **provide the Redis server for you**: it ships an add-on that adds a Redis
> service to your project (`ddev add-on get ddev/ddev-redis`, then
> `ddev restart`), which gives you a `redis` host reachable from the web
> container — handy for local development so you do not have to install a Redis
> server by hand.

## Enable the module

```bash
drush en redis -y
```

The module has no other Drupal module dependencies, so this enables only `redis`
itself.

## Verify it worked

Log in as an administrator and go to **Reports → Redis**
(`/admin/reports/redis`). Right after enabling — before you have added any
connection settings — the report will read **Not connected** with a note such as
*No Redis client connected. Verify cache settings.* That is expected: enabling the
module does not connect anything on its own.

![The Redis report before configuration, showing "Not connected"](../images/report.png)

To actually connect Drupal to your Redis server, continue to
[Configuration](../configuration/index.md).
