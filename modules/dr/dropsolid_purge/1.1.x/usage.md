Dropsolid Purge is a Purge module plugin that invalidates cached pages in one or more Varnish load balancers, scoping every invalidation to the current site via a per-site header. It is a generic rework of the Acquia Purge module usable in any environment.

---

The module plugs into the contrib **`purge`** framework (`purge:purge >= 3.0`, required) and provides
a **Purger** plugin (`dropsolid_purge`) that supports the `tag` and `everything` invalidation types.
It has **no settings form or configure route** — configuration is a `dropsolid_purge.config` array set
in **`settings.php`** (`$config['dropsolid_purge.config']`) holding `site_name`, `site_environment`,
`site_group` and a `loadbalancers` list (each with `ip`, `protocol`, `port`). The `HostingInfoFactory`
service builds load-balancer URIs from that config; the `HostingInfo` service derives a unique site
identifier (hash of site name + site path + environment + group) and an auth token
(`$settings['dropsolid_purge_token']`, defaulting to the site name). When Drupal serves a page, two
response headers are emitted via Purge TagsHeader plugins: **`X-Dropsolid-Purge-Tags`** (the hashed
cache tags) and **`X-Dropsolid-Site`** (the site identifier). On invalidation the purger sends BAN
requests (via an HTTP client middleware) to each configured load balancer, and Varnish — using the
bundled example VCL — bans only objects for this site, so multiple sites/subsites behind shared
Varnish don't clear each other. A DiagnosticCheck (`dropsolid_purge_configuration`) blocks the purger
from loading until it is fully configured. You still add and enable the purger through Purge itself
(`/admin/config/development/performance/purge` or `drush p:purger-add dropsolid_purge`), and pair it
with a Purge processor (cron + lateruntime recommended).

---

- Invalidate Varnish cache tags automatically when Drupal content changes, via the Purge queue.
- Run cache invalidation on any hosting (not just Acquia) that fronts Drupal with Varnish.
- Purge across **multiple** Varnish load balancers by listing them all in `loadbalancers`.
- Scope invalidations to a single site behind shared Varnish using the `X-Dropsolid-Site` header.
- Support "purge everything" (full ban) as well as targeted cache-tag invalidation.
- Configure load balancer IP/protocol/port entirely from `settings.php` (no UI, deploy-friendly).
- Give each environment (local/dev/stage/prod) its own site identifier via `site_environment`.
- Authenticate purge requests with a custom token (`$settings['dropsolid_purge_token']`).
- Use the bundled example VCL to implement the BAN logic in Varnish.
- Pair with the Purge cron processor plus lateruntime processor for fast invalidation.
- Add the purger through Purge's UI or `drush p:purger-add dropsolid_purge`.
- Diagnose misconfiguration via the `dropsolid_purge_configuration` Purge diagnostic check.
- Keep multisite installs isolated so one subsite's purge doesn't flush another's cache.
- Emit hashed cache-tag headers (`X-Dropsolid-Purge-Tags`) that Varnish bans against.
- Group related sites under one `site_group` for shared identification.
- Replace the Acquia-specific purger on a self-hosted Varnish stack.
- Batch large cache-tag sets into multiple BAN requests to keep header sizes safe.
- Migrate a site off Acquia while keeping tag-based Varnish invalidation working.
- Set up staging Varnish invalidation that never touches production caches.
- Ensure image-style/derivative caches are invalidated correctly (with the recommended core patch).
- Provide reverse-proxy cache clearing as part of a CI/CD deploy (via drush purge commands).
- Verify the purger only loads when its configuration is complete (diagnostic gating).
- Tune concurrency/timeouts of BAN requests through the purger's constants for large tag batches.
