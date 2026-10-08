<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Print This Page (print_this_page) — agent index

**Client-side print button (block + field formatter) that prints the current page and hides configurable elements.**

- **Version:** 1.0.x
- **Core:** ^10.1 || ^11 || ^12
- **Dependencies:** block
- **Package:** Content
- **Block:** `print_this_page_block` (category *Custom*) — settings `link_text`, `show_icon`, `exclude_list`
- **Formatter:** `print_this_page` for boolean/string/text/entity_reference fields — same three settings
- **Theme/library:** `print_this_page_button` hook + `print_this_page/print-button` (JS `window.print()`, print CSS); exclude list via `drupalSettings.printThisPage.excludeList`
- **Config:** stored in block/formatter settings; no module settings route, no permissions

**Security:** no server route or endpoint; entirely client-side. Nothing mutating; settings are admin-authored block/display config.

See [configure/block-and-formatter.md](configure/block-and-formatter.md)
