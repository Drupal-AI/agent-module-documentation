<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Greeting Cards (greeting_cards) — agent index
**Visitor uploads → merged PDF + thumbnail → `greeting_cards` node → e-mailed to a recipient.**

- **Version:** 1.0.x (dev-1.0.x checkout; project machine name `greeting_cards`, composer `drupal/cards`)
- **Core:** ^9.5 || ^10 || ^11
- **Depends:** entity_reference_revisions; libs: manager_assets, manager_card
- **External:** `mpdf/mpdf` (PDF), ImageMagick `convert` (thumbnails)
- **Routes (all `_permission: access content`):** `/printable-cards`, `/greeting-card-search`, `/greeting-cards/e-cards` (form), `/greeting-cards/e-cards/friends`, `/greeting-cards/e-cards/card/{nid}`, `/greeting-cards/e-cards/send`
- **Requires content model:** `greeting_cards` node type with `field_pdf`, `field_thumbnail_image`, `field_category`; `card_categories` vocabulary

See [configure/setup.md](configure/setup.md).
