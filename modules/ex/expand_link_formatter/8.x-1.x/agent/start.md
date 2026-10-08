<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Expand link formatter (expand_link_formatter) — agent index

**A field formatter that renders long text as a collapsed excerpt plus an expandable 'read more' section.**

- **Version:** 8.x-1.x (8.x-1.0-beta3)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Field types:** text_long, text_with_summary
- **Formatter id:** `expand_link_formatter` (`src/Plugin/Field/FieldFormatter/ExpandLinkFormatter.php`)
- **Settings:** separator (default `<hr>`), expand_link_label ("Read more"), collapse_link_label ("Read Less"), maxlength (0 = off).
- **Theme/JS:** `expand_link_formatter` template + `expand_link_formatter/expand` library; uses Views `FieldPluginBase::trimText` for auto-trim.

**Security:** display-only formatter; content rendered via `#type => processed_text` (field's text format), labels run through `Xss::filter`. No routes, permissions or mutation.

See [configure/formatter.md](configure/formatter.md).
