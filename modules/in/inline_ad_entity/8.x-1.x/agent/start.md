<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline Ad Entity (inline_ad_entity) — agent index

**Text-field formatter that inserts an Advertising Entity ad display between paragraphs of formatted text.**

- **Version:** 8.x-1.x
- **Core:** ^9 || ^10 || ^11 · **Package:** Advertising
- **Depends on:** ad_entity (Advertising Entity)
- **Formatter:** `inline_ad_entity` ("Content with Inline Ads") for `text`, `text_long`, `text_with_summary`.
- **Settings:** `ad_frequency` (int, default 3), `ad_display` (ad_display entity id); schema `field.formatter.settings.inline_ad_entity`.
- **Routes/permissions:** none of its own; uses ad_entity `ad_display` storage/view builder.

**Security:** no routes, permissions, or mutating endpoints; display-only formatter. Ad markup is produced by ad_entity, not this module. No security findings.

See [configure/formatter.md](configure/formatter.md).