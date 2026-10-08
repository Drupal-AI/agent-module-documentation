<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# URLs queuer (purge_queuer_url) — agent index

Add-on to the **Purge** module. Instead of purging by cache tag, it records which real
URLs were served (URL → cache-tags), and when Drupal invalidates a tag it looks up the
matching URLs from that "traffic registry" and queues *those exact URLs/paths* into Purge's
queue. For CDNs / older Varnish that can only drop a specific URL, not a tag.

- Depends on `purge`; composer `drupal/purge ^3.4`. Core `^10 || ^11`.
- **No dedicated settings route** (`configure` is null): configuration lives inside Purge UI's
  queuer config dialog for the `urlpath` queuer (needs purge_ui's `administer purge`). Config
  object `purge_queuer_url.settings`.
- Defines **no permissions**, no routes, no menu links.
- Provides plugin *instances* (a Purge queuer, a Purge diagnostic check), not new plugin types.
- Drush: a `sql:sanitize` plugin that clears the registry (not a standalone command).

Solutions:
- **Configure collection (paths vs URLs, host/scheme override, blacklist, clear history)** → [configure/settings.md](configure/settings.md)
- **Use / read the traffic registry service; how collection + queueing works at runtime** → [api/traffic-registry.md](api/traffic-registry.md)
- **What happens on `drush sql:sanitize`** → [drush/sql-sanitize.md](drush/sql-sanitize.md)

Key facts (real machine names):
- Queuer plugin id: `urlpath` (`UrlAndPathQueuerPlugin`, `enable_by_default = true`, configform = `ConfigurationForm`).
- Services: `purge_queuer_url.queuer` (tagged `cache_tags_invalidator`, class `UrlAndPathQueuer`),
  `purge_queuer_url.registry` (public, class `TrafficRegistry`),
  `http_middleware.purge_queuer_url_registrar` (tag `http_middleware`, priority 250, class `UrlRegistrar`).
- Diagnostic check plugin id: `purge_queuer_url_registry` (`RegistryCheck`).
- Config object `purge_queuer_url.settings` keys: `queue_paths`, `host_override`, `host`,
  `scheme_override`, `scheme`, `blacklist` (sequence).
- DB tables (`hook_schema`): `purge_queuer_url` (urlid, url, tag_ids), `purge_queuer_url_tag` (tagid, tag).
- `.info.yml` reports the legacy `version: '8.x-1.2'`.
