<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Common Overrides (common_overrides) — agent index

**Overrides hard-coded core behavior; currently rewrites the node search results title tag/text.**

- **Version:** 1.0.x
- **Core:** ^9.4 || ^10
- **Route/config:** `common_overrides.admin_settings` → `/admin/config/common_overrides` (`_permission: 'administer site configuration'`). Note: info.yml `configure` points at `common_overrides.admin.config`, which does not exist (mismatch).
- **Service:** `common_overrides.route_subscriber` (`RouteSubscriber`) replaces the controller of `search.view_node_search` with `CommonOverridesSearchController`.
- **Config:** `common_overrides.settings` → search_results_title, search_results_tag.

**Security:** single admin config route gated by `administer site configuration`; no anonymous or mutating endpoints. The results title is built with raw string concatenation into `#markup`, but both inputs are admin-controlled (tag from a fixed list), so risk is limited to privileged users.
