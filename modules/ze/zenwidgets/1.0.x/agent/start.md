<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ZEN widgets (zenwidgets) — agent index

**Embeds third-party zenwidgets.com widgets via a custom field, loaded by a site-wide injected script.**

- **Version:** 1.0.x — core `^10 || ^11`.
- **Script:** `hook_page_bottom` → `ZenWidgetsService::getScriptRenderArray()` renders `<script type=module async src="<domain>/scripts/index.js" data-zen-website-id data-zen-website-token>` (default domain `https://www.zenwidgets.com`).
- **Field:** field type `WidgetItem` + widget + `WidgetDefaultFormatter` (renders `<span data-zen-widget-id …>`); `getWidgets()` GETs `<domain>/api/widgets` (Guzzle) to list widgets.
- **Config:** `/admin/config/services/zenwidgets` (`zenwidgets.config`, permission `administer ZEN widgets configuration`, restricted) — website id + authentication token.
- **Security observations:** the **authentication token is emitted into public page HTML** (`data-zen-website-token`) on every page by design, and `getWidgets()` passes it as a **URL query parameter** to the configured domain (logged on error). TLS via Guzzle defaults (verify ON); only the configured `domain` sets the scheme — do not configure an `http://` domain. No hardcoded secrets, no `verify=>false`. See [configure/setup.md](configure/setup.md).
