# acquia_purge — agent start

Purge "purger" for Acquia Cloud: clears Varnish load balancers and the Acquia Platform CDN
when Drupal content changes. Provides purger plugins `acquia_purge` (Acquia Cloud) and
`acquia_platform_cdn`, plus TagsHeader and DiagnosticCheck plugins. Depends on `purge` and
`purge_queuer_coretags`. Zero-config by design: **no admin UI, no config forms** — set up with
Drush, tune via `settings.php`.

- Enable + register the purgers, tuning keys in settings.php → [configure/setup.md](configure/setup.md)
- Platform detection service, purger/backend plugin classes → [api/api.md](api/api.md)
- Submodule `acquia_purge_geoip` (Vary by X-Geo-Country) → [../../modules/acquia_purge_geoip/1.5.x/agent/start.md](../../modules/acquia_purge_geoip/1.5.x/agent/start.md)
