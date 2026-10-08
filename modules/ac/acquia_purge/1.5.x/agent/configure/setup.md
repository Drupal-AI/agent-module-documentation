# Setup & tuning — Acquia Purge

There is **no config UI and no config form** (deliberate design: only site admins should change
behavior, and changes must be traceable in `settings.php`). `configure` route is `null`.
Setup is done entirely with Drush against the Purge module.

## Enable modules

```
drush en acquia_purge --yes
# supporting Purge components (queuer + processors + drush + ui):
drush en purge_drush purge_queuer_coretags purge_processor_lateruntime purge_processor_cron purge_ui --yes
```

`acquia_purge` already declares `purge:purge` and `purge:purge_queuer_coretags` as dependencies.

## Register the purger plugins

```
# Acquia Cloud Varnish load balancers (plugin id: acquia_purge):
drush p:purger-add --if-not-exists acquia_purge

# (optional) Acquia Platform CDN (plugin id: acquia_platform_cdn):
drush p:purger-add --if-not-exists acquia_platform_cdn
drush p:purger-ls
drush p:purger-mvu <instance-id>   # reorder execution
```

## Verify

```
drush p:diagnostics --fields=title,severity
```

Relevant diagnostic checks the module provides: `acquia_purge_cloud_check` (Acquia Cloud),
`acquia_purge_platformcdn_check` (Platform CDN), `acquia_purge_recommendations_check`.

## settings.php tuning keys

The module reads these from Drupal settings / site info — it does not store config:

- `$settings['acquia_purge_token']` — default unset (falls back to the Acquia site name). If set,
  overrides the `X-Acquia-Purge` header value used to authenticate purge requests; helps offset
  DDOS-style attacks but requires matching balancer config from Acquia Support.
- `$settings['reverse_proxies']` — array of public load-balancer IPs; the source of the balancer
  addresses Acquia Purge sends BAN/PURGE requests to. (Distinct from `reverse_proxy_addresses`.)
- `$settings['acquia_service_credentials']['platform_cdn']` — vendor + configuration for the
  Acquia Platform CDN purger (otherwise read from state `acquia_purge.platform_cdn` during beta).

Environment facts (site name, group, environment, unique site identifier) are auto-detected on
Acquia Cloud via `ah_site_info_keyed()` (or ACSF `$GLOBALS['gardens_site_settings']`).
