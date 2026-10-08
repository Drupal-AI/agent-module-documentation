# Purge plugins provided by Dropsolid Purge

The module ships no plugin *type* of its own — it implements plugins for the contrib **purge**
framework. There is no configure route; behaviour is driven by `dropsolid_purge.config` and the
Purge configuration.

## Purger — `dropsolid_purge`

`@PurgePurger(id = "dropsolid_purge", label = "Dropsolid Varnish Purge", multi_instance = FALSE,
types = {"tag", "everything"}, cooldown_time = 0.2)`

- Supports invalidation types **`tag`** (cache-tag BAN) and **`everything`** (full ban). `url` /
  `wildcardurl` are noted as future work, not supported.
- Sends BAN requests concurrently (up to `CONCURRENCY = 6`) to every configured load-balancer URI,
  via Guzzle with `CONNECT_TIMEOUT = 1.5s`, `TIMEOUT = 3.0s`.
- Cache tags are hashed and grouped `TAGS_GROUPED_BY = 15` per request to keep headers small.
- Add an instance with `drush p:purger-add dropsolid_purge`.

## Tags-header plugins (response headers)

| Plugin id | Header | Value |
|---|---|---|
| `dropsolidpurgetagsheader` | `X-Dropsolid-Purge-Tags` | space-joined **hashed** cache tags (`Hash::cacheTags()`) |
| `dropsolidpurgesiteheader` | `X-Dropsolid-Site` | this site's identifier (`HostingInfo::getSiteIdentifier()`) |

Varnish stores these on cached objects; a BAN matches on them so only this site's objects are
invalidated.

## Diagnostic check — `dropsolid_purge_configuration`

`@PurgeDiagnosticCheck(id = "dropsolid_purge_configuration", dependent_purger_plugins =
{"dropsolid_purge"})` — "Verifies that only fully configured Varnish purgers load." Shows in
`drush p:diagnostics` and gates the purger until `dropsolid_purge.config` is complete.

## HTTP client middleware

`http_client_middleware.dropsolid_purge` (`LoadBalancerMiddleware`) is tagged
`http_client_middleware` and shapes the outbound BAN requests.
