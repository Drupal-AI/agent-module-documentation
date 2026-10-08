# Configuration

Redis Batch has no settings form of its own. It stores batch data in Redis, so
its "configuration" is simply having a working **Redis connection**, which you set
up through the [Redis](https://www.drupal.org/project/redis) module in your site's
`settings.php`.

## Point the site at your Redis server

Add the Redis module's connection settings to `settings.php` (or a
`settings.local.php` it includes). At minimum, tell Drupal to use Redis and where
to find it — for example:

```php
$settings['redis.connection']['interface'] = 'PhpRedis'; // or 'Predis'
$settings['redis.connection']['host'] = '127.0.0.1';     // your Redis host
$settings['redis.connection']['port'] = 6379;            // your Redis port
```

> **Using DDEV?** The host is the Redis service name inside the project (for
> example `redis`), not `127.0.0.1`. Check the settings snippet printed by your
> Redis add‑on and use the host and port it reports.

Consult the Redis module's own documentation for the full set of options
(database index, persistent connections, cache‑prefix, and so on) and for the
recommended way to also route Drupal's cache backends through Redis if you want.

## Credentials belong in the environment

If your Redis server requires a password, **do not hard‑code it** in a file that
gets committed. Keep it in an environment variable and read it in `settings.php`,
for example:

```php
$settings['redis.connection']['password'] = getenv('REDIS_PASSWORD');
```

With DDEV, store the value with `ddev dotenv set .ddev/.env
--redis-password=<value>` (keep `.ddev/.env` out of version control) and
`ddev restart` so the container picks it up.

## No per‑module toggle to fill in

Once the Redis connection is in place and both modules are enabled, Redis Batch
takes over batch storage — there is nothing further to configure in the admin UI.
Run a batch operation to confirm it works end to end.
