<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alternative Hreflang for SEO (seo_alt_hreflang) — agent index

**Rewrites the language code in `hreflang` link/switcher attributes to an admin-configured alternative, without changing the site's registered langcodes or URLs.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends on:** core `language`
- **Route:** `seo_alt_hreflang.settings_form` → `/admin/config/regional/language/seo-alt-hreflang`
- **Permission:** `administer seo alt hreflang configuration` (restrict access: true)
- **Hooks:** `hook_page_attachments_alter()` (rewrites `html_head_link` alternates), `hook_language_switch_links_alter()` (rewrites switcher link attributes); skips 403/404
- **Config:** `seo_alt_hreflang.settings:seo_alt_hreflang_list` (langcode → alternative code map)
- **Security:** single admin config route, permission-gated with restrict access; output values are `Html::escape()`d; no anonymous or mutating endpoints.