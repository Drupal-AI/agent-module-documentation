<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Status Message (site_status_message) — agent index

**Shows a configurable site-wide banner at page top, with optional read-more link and public/admin scoping.**

- **Version:** 2.1.x
- **Core:** ^9 || ^10 || ^11
- **Package:** Site Status Message
- **Route:** `site_status_message.admin_settings` → `/admin/config/system/site-status-message` (permission `administer site status message`)
- **Permission:** `administer site status message`
- **Config:** `site_status_message.settings` (`enable`, `message`, `showlink`, `link`, `readmore`, `display_options`)
- **Render:** `hook_page_top` → `site_status_message` theme hook; `Xss::filter` + `token.replace`; per-viewer `#access` = `access content`; display scoping public(0)/admin(1)/both(2)

**Security:** admin settings route gated by `administer site status message`. Message is `Xss::filter`ed before the template's `|raw`, and the field is admin-only; token replacement runs on admin-authored text. No anonymous mutating endpoints.

See [configure/settings.md](configure/settings.md)
