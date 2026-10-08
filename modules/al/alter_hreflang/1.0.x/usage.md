<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: rewrites the `hreflang` value of the `<link rel="alternate">` head links Drupal emits per page.
- When: your site's Drupal language code differs from the ISO code search engines expect (e.g. mapping `en` to `en-US`, `pt-br` to `pt-BR`).

---

- Install the module and enable it; no dependencies beyond core.
- Configure at `/admin/config/regional/alter-hreflang` (route `alter_hreflang.hreflang`), guarded by the `administer site configuration` permission.

---

- Provides `hook_page_attachments_alter()` in `alter_hreflang.module` that injects `#attached['html_head_link']` alternate links.
- For single-language sites it emits one alternate link for the current path using the aliased URL.
- For multilingual sites it uses `language_manager` language-switch links and only emits links for languages the current node is translated into.
- Each language's override code is read from config key `language_<langcode>` in `alter_hreflang.settings`.
- If no override is set for a language, the raw Drupal langcode is used as a fallback.
- Skips 403/404 pages by checking for an `exception` request attribute.
- Preserves current query-string parameters when building the alternate URLs on multilingual sites.
- Absolute URLs are built from the global `$base_url` plus the path alias.
- Use it to satisfy Google's hreflang region-code expectations without patching core.
- Set overrides on the settings form for every enabled language you want remapped.
- Front page is handled via the `<front>` route; other pages via `<current>`.
- No permissions, services, or blocks are provided by the module.
- Works alongside core's built-in content-translation hreflang without a separate metatag module.
- Verify output by viewing page source and inspecting the `<link rel="alternate" hreflang="...">` tags.
- Clear caches after changing overrides so head-link attachments regenerate.
- Note: on a multilingual page with no node parameter the module assumes a node route; non-node routes may not receive per-translation links.
