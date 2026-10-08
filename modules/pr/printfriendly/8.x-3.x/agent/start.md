<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PrintFriendly & PDF (printfriendly) — agent index
**Integrates the third-party PrintFriendly.com button so visitors can print, PDF, or email a cleaned-up page. No API key.**

- **Version:** 8.x-3.x (release 8.x-3.6). **Core:** `^8 || ^9 || ^10 || ^11`. No dependencies.
- **Config object:** `printfriendly.settings` (no config schema shipped).
- **Route:** `printfriendly.config` → `/admin/config/printfriendly/config`, permission `administer printfriendly`.
- **View permission:** `access printfriendly` (needed to see the button).
- **Button placement:** (1) `hook_node_view` auto-appends to selected content types + optional teaser; (2) block plugin `block_printfriendly` ("printfriendly") for the Block layout. Both call `printfriendly_create_button()`.
- **Third-party service:** attaches inline JS loading `//cdn.printfriendly.com/printfriendly.js` + a CSS library via `hook_page_attachments`; button links to `https://www.printfriendly.com/print?url=<page>`.
- **Note:** `printfriendly_upgrade_db()` runs on every request to migrate legacy button-image filenames.

See [configure/settings.md](configure/settings.md) for the settings form, all config keys, and placement.
