<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure an HTTP purger

## The two purger plugins

| Plugin id | Class | Behaviour |
|---|---|---|
| `http` | `HttpPurger` | Fires one HTTP request **per** invalidation instruction. |
| `httpbundled` | `HttpBundledPurger` | Fires **one** request for the whole set of invalidations. |

Both are `multi_instance = TRUE` and extend `HttpPurgerBase`. Their config forms are
`HttpPurgerForm` / `HttpBundledPurgerForm`.

## Where instances are added

The module defines **no route of its own** (`configure: null`). You add and remove purger
instances through the **Purge** UI at *Configuration › Development › Performance › Purge*
(`/admin/config/development/performance/purge`) → "Add purger", then edit the instance to
open this module's settings form. Each instance you add gets a Purge-generated instance id.

## The settings entity

Every instance's configuration is a `httppurgersettings` config entity, config prefix
`settings`, so its config object is **`purge_purger_http.settings.<instance_id>`**
(load with `HttpPurgerSettings::load($id)`). Exported fields and defaults:

| Field | Default | Meaning |
|---|---|---|
| `name` | `''` | Human-readable label of the purger. |
| `invalidationtype` | `tag` | Purge invalidation type handled (`tag`, `path`, `url`, `wildcardpath`, `everything`, …). |
| `hostname` | `localhost` | Host/IP to connect to. |
| `port` | `80` | Port. |
| `path` | `/` | Request path (token-aware). |
| `request_method` | `BAN` | HTTP method (BAN, PURGE, DELETE, GET, POST, …). |
| `scheme` | `http` | `http` or `https`. |
| `verify` | `TRUE` | Verify TLS cert (only applied when scheme is https). |
| `headers` | `[]` | List of `{field, value}` outbound headers (values token-aware). |
| `body` | `''` | Request body (token-aware); sets `content-type` header when non-empty. |
| `body_content_type` | `text/plain` | Content-type used when a body is sent. |
| `runtime_measurement` | `TRUE` | Dynamically measure capacity; if FALSE, capacity derives from timeouts. |
| `timeout` | `1.0` | Request timeout (seconds, float). |
| `connect_timeout` | `1.0` | Connect timeout (seconds, float). |
| `cooldown_time` | `0.0` | Seconds to wait after invalidations so caches settle. |
| `max_requests` | `100` | Max HTTP requests per Drupal execution. |
| `http_errors` | `TRUE` | Treat 4xx/5xx as failures (Guzzle `http_errors`). |

## Create/configure programmatically

```php
use Drupal\purge_purger_http\Entity\HttpPurgerSettings;

$s = HttpPurgerSettings::create(['id' => 'cdn']);
$s->name = 'CDN';
$s->invalidationtype = 'tag';
$s->hostname = 'cache.example.com';
$s->port = 80;
$s->request_method = 'PURGE';
$s->scheme = 'http';
$s->save(); // -> purge_purger_http.settings.cdn
```

To actually run, the matching purger instance (id = the settings id) must also be enabled in
Purge (`purge.plugins` — normally done through the purgers UI above).

## Diagnostic check

`httpconfiguration` (`ConfigurationCheck`, id `httpconfiguration`, dependent purger `http`)
appears on Purge's status page. It errors if an enabled HTTP purger is missing `name`,
`hostname`, `port`, `request_method`, or `scheme`, and warns when `scheme: https` is not on
port 443 (or `scheme: http` is on 443).
