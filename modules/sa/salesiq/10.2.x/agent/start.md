<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zoho SalesIQ (zohosalesiq) — agent index

**Embeds the Zoho SalesIQ live-chat/tracking widget snippet on site pages.**

- **On-disk / project name:** salesiq · **machine name:** zohosalesiq
- **Version:** 10.2.x
- **Core:** ^8.0 || ^9 || ^10
- **Configure:** `/admin/config/services/zohosalesiq`
- **Permission:** `administer zohosalesiq`

**Surface:** `SettingsForm` stores `zohosalesiq_widget_code`; `hook_page_attachments()` (in `zohosalesiq.module`) validates via regex and prints the snippet as an inline `<script>`. No server-side HTTP calls.

**Security:** widget code settable only by `administer zohosalesiq` admins. `_zohosalesiq_construct_ready_function()` puts the CURRENT user's own name/email into an inline script. No TLS/secret handling in PHP.
