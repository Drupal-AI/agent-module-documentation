<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Skillset Inview (skillset_inview) — agent index

**Field type + widget + formatters + block for animated skill/proficiency bars on portfolio sites.**

- **Version:** 3.0.x (dev-3.0.x) · **Core:** ^10.3 || ^11 · **Depends:** block, serialization
- **Configure:** `skillset_inview.order` (overview/reorder).
- **Routes:** `skillset_inview.color` (theme colours form), `skillset_inview.preview` — both `_permission: 'administer skillset inview'`.
- **Permission:** `administer skillset inview`.
- **Services:** Twig extensions `unescape` (html_entity_decode, `is_safe: html`) and `HexToRgb`.
- **Field API:** `SkillsetItem` field type, widget, two formatters (standard + meter).
- **Security:** admin routes permission-gated; no anonymous or mutating endpoints. Note: the `unescape` Twig filter emits its input as safe HTML — only feed it trusted editor-entered data.
