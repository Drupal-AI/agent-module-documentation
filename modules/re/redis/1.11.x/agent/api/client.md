# Redis client API

The module is a "placeholder" so other modules can reuse its Redis client. Get a raw client
through the `redis.factory` service (`Drupal\redis\ClientFactory`).

```php
/** @var \Drupal\redis\ClientFactory $factory */
$factory = \Drupal::service('redis.factory');
$client  = $factory->getClient(); // \Redis | \Relay\Relay | \Predis\Client | \RedisCluster
$client->set('mymodule:key', 'value');
```

Static helpers (no service needed):
```php
\Drupal\redis\ClientFactory::hasClient();     // bool — is a connection configured?
\Drupal\redis\ClientFactory::getClientName(); // 'PhpRedis' | 'Relay' | 'Predis'
```
The returned object is the native client of whichever interface is configured, so call methods
against that library's API directly.

Other factory services you can reuse: `redis.lock.factory` (`LockFactory::get()`),
`redis.flood.factory` (`FloodFactory::get()`), `queue.redis` / `queue.redis_reliable`.

Source: `src/ClientFactory.php`, `src/ClientInterface.php`, `redis.services.yml`.
