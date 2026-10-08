# Configuration

Configuration comes in two parts: a small settings **form** for the endpoint path
and metric namespace, and a few **`settings.php`** entries for the storage
backend. Protecting the endpoint is the part to get right.

## The settings form

Go to **Configuration → System → Prometheus**
(`/admin/config/system/prometheus`), which requires the **Administer site
configuration** permission. There you can set:

- **Endpoint** — the path where metrics are served (default `/metrics`). Point
  your Prometheus server's scrape config at whatever you set here.
- **Namespace** — the prefix applied to the metric names this module exposes
  (default `drupal`).

## Protecting the endpoint (important)

Metrics can reveal operational detail — route names, traffic patterns, entity
activity — so the endpoint should not be world-readable unless you truly intend it
to be. This module is **secure by default**: its access checker defaults
`require_auth` to **TRUE** and then requires the **Access prometheus metrics**
permission. An anonymous scraper is therefore denied unless you change something.

To let Prometheus scrape, choose one of these, in rough order of preference:

- **Grant the *Access prometheus metrics* permission** to the role your scraper
  authenticates as — ideally only where the endpoint is reachable from a
  firewalled/internal network. Granting it to the anonymous role exposes metrics
  to anyone who can reach the URL, so do that only on a network-isolated endpoint.
- **Use basic authentication** in front of the endpoint so the scraper
  authenticates as a user who holds the permission.
- **Set `require_auth = FALSE`** to turn off the module-level check — but do this
  **only** when the endpoint is protected at the network layer (for example, an
  internal-only address or an IP allow-list at the reverse proxy). Without network
  protection this makes your metrics anonymously readable.

Keep the endpoint's access as tight as your monitoring setup allows.

## Storage backend (settings.php)

The collected data is held in a storage backend. The default is the library's
**in-memory** adapter, which needs no extra configuration. To change it, add
settings to your site's `settings.php`:

```php
// APCu (requires the apcu PHP extension):
$settings['prometheus_metrics_storage_type'] = 'apc';

// or Redis (requires the redis PHP extension):
$settings['prometheus_metrics_storage_type'] = 'redis';
```

For Redis, also define the connection details:

```php
$settings['prometheus_metrics_redis_host'] = 'redis-host';
$settings['prometheus_metrics_redis_port'] = 3679;
$settings['prometheus_metrics_redis_timeout'] = 0.1;
$settings['prometheus_metrics_redis_read_timeout'] = 10;
$settings['prometheus_metrics_redis_persist_conns'] = false;
$settings['prometheus_metrics_redis_database'] = null;
```

Both the APCu and Redis adapters require their respective PHP extension to be
installed and enabled.

## Metrics you get by default

Out of the box the module exposes request timings and request counts (by route,
method, and status code) and entity CRUD metrics (create/update/delete, by
bundle). With `prometheus_metrics_commerce` enabled you also get commerce metrics.
