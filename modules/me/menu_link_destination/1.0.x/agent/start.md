<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Link Destination (menu_link_destination) — agent index

**Adds a `destination` query parameter to flagged menu links, sourced from the current page's `destination` param or the current URL.**

- **Version:** 1.0.x
- **Core:** >=10
- **Config surface:** YAML links add `destination: true` (`hook_menu_links_discovered_alter`); `menu_link_content` links get an "Add a destination query parameter" checkbox (form alter + entity builder)
- **Runtime:** `hook_link_alter()` injects `query.destination` from `redirect.destination` unless already set; `MenuLinkDestination::preRenderLink()` (TrustedCallback, via `hook_element_info_alter`) adds a `url` cache context
- **Routes / permissions / services:** none of its own

**Security:** Destination value comes from core's `redirect.destination`; core rejects external destinations when performing a redirect, so this adds **no open-redirect** beyond core's guarded behaviour. Configuration is admin-gated (menu-link form / module YAML). No anonymous or mutating endpoints. Correctly applies a `url` cache context to affected links.

See [configure/destination.md](configure/destination.md)
