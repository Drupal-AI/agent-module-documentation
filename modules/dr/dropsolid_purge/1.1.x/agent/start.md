# Dropsolid Purge — agent index

A **Purge** plugin that invalidates Varnish load balancers, scoping each ban to the current site.
Requires the contrib `purge` module (`purge:purge >= 3.0`). No settings form or configure route —
it is configured in `settings.php` and enabled through Purge itself.

- **Configuration: the `dropsolid_purge.config` array in settings.php, the token, adding the purger
  to Purge** → [configure/settings.md](configure/settings.md)
- **The Purge plugins it provides (purger, tags headers, diagnostic check)** →
  [plugins/purge-plugins.md](plugins/purge-plugins.md)
- **The services (`HostingInfo`, `HostingInfoFactory`) and how the site identifier is derived** →
  [api/hosting-info.md](api/hosting-info.md)

Key facts: purger plugin id `dropsolid_purge` (types `tag`, `everything`). Response headers
`X-Dropsolid-Site` (site id) and `X-Dropsolid-Purge-Tags` (hashed tags). Config object
`dropsolid_purge.config` (`site_name`, `site_environment`, `site_group`, `loadbalancers[]`). Add via
`drush p:purger-add dropsolid_purge`. Ground evals in local config — **no live Varnish calls**.
