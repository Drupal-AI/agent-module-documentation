# Setup & configuration — Varnish Purger

The module (`varnish_purger`) has **no admin route** — `configure` is `null`. Purgers are
added and configured through the Purge module's UI (`purge_ui`, at
`/admin/config/development/performance/purge`) or with Drush. Each configurable purger
instance stores its settings in a `varnishpurgersettings` config entity
(`varnish_purger.settings.<random-id>`).

## Enable

```
drush en varnish_purger -y
# supporting Purge pieces (queuer + a processor + UI + drush):
drush en purge purge_tokens purge_ui purge_drush purge_queuer_coretags purge_processor_cron -y
```

`varnish_purger` already declares `purge:purge` and `purge:purge_tokens` as dependencies.
`purge_tokens` is what enables `[invalidation:expression]`-style token replacement in the
purger's path and header fields.

## Add a purger (Drush)

```
drush p:purger-ls                    # list configured purgers
drush p:purger-add varnish           # HTTP purger, one request per invalidation
drush p:purger-add varnishbundled    # one HTTP request per batch of invalidations
drush p:purger-add varnish_zeroconfig_purger
drush p:diagnostics                  # 'Varnish' (varnishconfiguration) check must be OK
```

The `varnish` and `varnishbundled` purgers each expose a config form (Purge UI →
"Configure" on the purger). The `varnish_zeroconfig_purger` has **no config form**
(`configform = ""`) — see the settings.php section below.

## Configurable purger settings (varnish / varnishbundled)

Stored on the `VarnishPurgerSettings` config entity; form is grouped in vertical tabs.
Defaults shown in parentheses.

| Key | Meaning |
|---|---|
| `name` | Human label for this purger instance (required). |
| `invalidationtype` (`tag`) | The single invalidation type this purger clears. Populated from Purge's invalidation plugins (tag, url, wildcardurl, everything, path, …). |
| `hostname` (`localhost`) | Varnish host or IP to connect to. |
| `port` (`80`) | Varnish port. |
| `path` (`/`) | Request path; Purge tokens are replaced here. |
| `request_method` (`BAN`) | HTTP method — only `BAN` or `PURGE` are offered. |
| `scheme` (`http`) | `http` or `https`. |
| `verify` (`TRUE`) | Verify SSL cert (only relevant when scheme is `https`; uncheck for self-signed — insecure). |
| `headers` (`[]`) | Table of outbound `field`/`value` header pairs; token-replaced. Example for tag purging: header `Cache-Tags`, value `[invalidation:expression]`. |
| `cooldown_time` (`0.0`) | Seconds to wait after a group of requests so other purgers get fresh content (0.0–3.0). |
| `max_requests` (`100`) | Max HTTP requests per Drupal execution lifetime (1–50000). |
| `runtime_measurement` (`TRUE`) | When on, Purge auto-measures capacity; when off, capacity = connect_timeout + timeout. |
| `timeout` (`1.0`) | Request timeout in seconds (0.1–8.0; used when runtime_measurement off). |
| `connect_timeout` (`1.0`) | Connection timeout in seconds (0.1–4.0). |
| `http_errors` (`TRUE`) | Treat 4xx/5xx responses as failed invalidations. |

Validation: `connect_timeout + timeout` must be between **0.4 and 10.0** seconds.

There is no `config/install`; a purger entity is created only when you add a purger, and
its id gets a random suffix (e.g. `varnish_purger.settings.a1b2c3`).

## Zero-config purger (settings.php)

`varnish_zeroconfig_purger` reads Varnish server addresses from Drupal core's
`$settings['reverse_proxy_addresses']` (IP strings; ports are not taken from there) and is
meant to be used with the module's shipped `zeroconfig.vcl` (Varnish 4). It supports `url`,
`wildcardurl`, `tag` and `everything` in one plugin, concurrency 6, tags grouped 15 per BAN
request. Copy/adapt `zeroconfig.vcl` into your Varnish config; it accepts `PURGE` (single
URL), `BAN` (Cache-Tags header, pipe-separated), and wildcard-URL bans.
