# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contributed **[Redis](https://www.drupal.org/project/redis)** module
  (`redis`) — Composer pulls it in for you.
- A reachable **Redis server**, and a way for PHP to talk to it — either the
  `phpredis` PHP extension or the `predis/predis` library (the Redis module
  supports both). With DDEV, add the Redis service (for example the
  `ddev-redis` add‑on) so a Redis server is available inside the project.

## Install with Composer

From the project root:

```bash
composer require drupal/redis_batch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Redis module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redis_batch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redis_batch -y
```

Drupal enables the Redis dependency automatically if it isn't already on.

## Configure the Redis connection

Redis Batch relies on the Redis module's connection settings — so the real setup
step is pointing your site at Redis in `settings.php`. See
[Configuration](../configuration/index.md).

## Verify it worked

Confirm both modules are enabled (`drush pml | grep -E 'redis|redis_batch'`) and
that the Redis connection is working (the Redis module's report at
**Reports → Status report** shows a connected Redis client). Then run a batch
operation — for example a bulk content action — and it should complete normally,
now with its progress stored in Redis.
