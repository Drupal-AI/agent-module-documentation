<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Menu Anchor (paragraphs_menu_anchor) — agent index

**Anchor field for paragraphs + a block that renders in-page jump-link navigation from those anchors.**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** ^9 || ^10 || ^11
- **Dependency:** paragraphs
- **Field plugins:** `PmaAnchorItem` (field type), `PmaAnchorWidget` (widget), `PmaAnchorFormatter` (formatter).
- **Block:** `ParagraphsMenuAnchorBlock` — builds the anchor menu from the paragraphs on the current entity.
- **Routes/permissions:** none.

**Security:** Pure field-plugin + block module; no routes, permissions or endpoints. Access follows field access and block visibility. No security findings.
