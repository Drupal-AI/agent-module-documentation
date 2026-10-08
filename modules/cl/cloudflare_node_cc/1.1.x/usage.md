<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Node Cache Clear purges a site's Cloudflare edge cache — either an entire zone site-wide or the URLs of a single node on save — can map languages to separate Cloudflare zones/domains, and ships Drush commands for scripted flushes. This 1.1.x branch runs on Drupal 10 and 11.

---

The module wraps the `cloudflare/sdk` PHP library. An admin picks either API-Key (email + Global API Key) or API-Token auth, and the secret is referenced through a Key entity resolved by `CloudflareService::getApiKey()/getApiToken()` via `key.repository` (dependency on the Key module) — only the Key's machine name is kept in the module's configuration. Connection and behaviour settings (auth type, email, key/token name, zone id, multi-zone language→zone/domain maps, and UI toggles) live in the simple config object `cloudflare_node_cc.settings`, which has a config schema. `CloudflareService` lists zones, purges everything in a zone (`purgeZoneCache`), purges specific files/URLs (`purgeZoneCacheFiles`), and can read or set a zone's firewall security level.

Operators configure it at `/admin/config/services/cloudflare-node-cache-clear` (`administer cloudflare_node_cc`). A "Save & Purge Cloudflare Cache" button is added to node edit forms for users holding `cloudflare_node_cc purge cache per node`, and a site-wide purge is available at `/admin/cloudflare-node-cache-clear/purge-cache` (permission `cloudflare_node_cc purge cache`), with an optional confirmation step. Two Drush commands — `cloudflare-node-cc:flush-cache` and `cloudflare-node-cc:attack-mode` — make flushes and under-attack-mode scriptable. An optional event subscriber (`CloudflareClientIpRestore`) rewrites `REMOTE_ADDR` from the `CF-Connecting-IP` request header so Drupal sees the real visitor IP behind the Cloudflare proxy.

---

- Purge a single node's cache when it is saved from the node form
- Purge an entire Cloudflare zone site-wide from an admin action
- Add a confirmation step before a site-wide purge
- Always purge on the normal node Save button instead of a second button
- Also purge the site front page when its node is purged
- Log a message on every purge for auditing
- Store the Cloudflare API key/token in a Key entity, referenced by name
- Use Global API Key + email authentication
- Use a scoped API Token instead of the global key
- Map each site language to its own Cloudflare zone id
- Map languages to distinct domains for multilingual purges
- Purge specific file URLs rather than the whole zone
- Grant editors purge rights without full site administration
- Separate per-node purge permission from site-wide purge permission
- Restore the real client IP behind the Cloudflare proxy
- Flush cache from the command line with `drush cloudflare-node-cc:flush-cache`
- Target a Drush flush by zone, path, content type, or node id
- Place a zone into under-attack mode with `drush cloudflare-node-cc:attack-mode`
- Automate edge-cache invalidation on content publish
- Trigger a site-wide purge after a deployment via Drush
- List available Cloudflare zones for the configured account
- Validate a zone id against the account when saving settings
- Run on both Drupal 10 and Drupal 11 sites
