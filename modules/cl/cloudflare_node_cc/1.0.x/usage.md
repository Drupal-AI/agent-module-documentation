<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Node Cache Clear purges a site's Cloudflare edge cache — either an entire zone site-wide or the URLs of a single node on save — and can map languages to separate Cloudflare zones/domains.

---

The module wraps the `cloudflare/sdk` PHP library. Credentials are never stored in config directly: an admin picks either API-Key (email + Global API Key) or API-Token auth, and the secret is referenced through a Key entity resolved by `CloudflareService::getApiKey()/getApiToken()` via `key.repository` (dependency on the Key module). Connection settings (email, auth type, key/token name, zone id, multi-zone map, language→domain map) are kept in Drupal `state`. `CloudflareService` lists zones, purges everything in a zone (`purgeZoneCache`), or purges specific files (`purgeZoneCacheFiles`).

Operators configure it at `/admin/config/cloudflare-node-cache-clear` (`administer cloudflare_node_cc`). A "Save & Purge Cloudflare Cache" button is added to node edit forms for users holding `cloudflare_node_cc purge cache`, and a site-wide purge is available at `/admin/cloudflare-node-cache-clear/purge-cache` (same permission) which redirects back to the referrer. An optional event subscriber (`CloudflareClientIpRestore`, opt-in via the `cloudflare_restore_client_ip` state flag) rewrites `REMOTE_ADDR` from the `CF-Connecting-IP` request header so Drupal sees the real visitor IP behind Cloudflare. Note that this subscriber trusts the header without validating that the request actually originates from a Cloudflare IP range — see the security note in the agent index.

---

- Purge a single node's cache when it is saved from the node form
- Purge an entire Cloudflare zone site-wide from an admin action
- Store the Cloudflare API key/token in a Key entity, not in config
- Use Global API Key + email authentication
- Use a scoped API Token instead of the global key
- Map each site language to its own Cloudflare zone id
- Map languages to distinct domains for multilingual purges
- Purge specific file URLs rather than the whole zone
- Grant editors purge rights without full site administration
- Restore the real client IP behind the Cloudflare proxy
- List available Cloudflare zones for the account
- Look up the Cloudflare user id for the configured credentials
- Automate edge-cache invalidation on content publish
- Keep CDN cache fresh for media-heavy pages
- Separate purge permission from configuration permission
- Trigger a site-wide purge after a deployment
- Redirect the editor back to the page they purged from
- Configure single-zone vs. multi-zone behavior
