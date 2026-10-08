<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inpage navigation (inpagenav) — agent index

**Block that builds an in-page table-of-contents from configured heading tags and wrapper-class rules.**

- **Version:** 10.0.x
- **Core:** ^8 || ^9 || ^10
- **Configure:** `inpagenav.settings` → `/admin/structure/inpagenav/settings/config_settings` (`administer site configuration`).
- **Config object:** `inpage.settings` (`parent_wrappper`, `tag_wrapper`, `card_tag_wrapper`, `tags_to_include`).
- **Block:** `inpage` (`InPageNav`) → theme `inpagenav`, library `inpagenav/inpagenav`; TOC built client-side from `drupalSettings`.

**Security:** presentational block only — the sole route is the admin settings form gated by `administer site configuration`; no anonymous mutating endpoints, permissions, or external I/O. TOC is rendered client-side from the page DOM.

See [configure/settings.md](configure/settings.md).
