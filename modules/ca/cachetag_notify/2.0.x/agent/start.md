<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CacheTag Notify (`cachetag_notify`) — agent index
**POSTs a JSON list of invalidated cache tags to a configured URL (CDN/proxy/rebuild hook).**

- **Version:** 2.0.x  | **Core:** ^8.8 || ^9 || ^10
- **Configure:** `/admin/config/system/cachetag_notify` (`cachetag_notify.settings`, perm `administer site configuration`)
- Service `CacheTagsInvalidator` (tagged `cache_tags_invalidator`) → `httpClient->post($endpoint, json_encode($tags))` via Guzzle; TLS at defaults (verify enabled).

**Security:** the destination URL is admin-configured (not request-controlled), so no anon SSRF; TLS verification is not disabled. No verified finding.
