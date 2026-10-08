<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cards (cards) — agent index

**Field types/widgets/formatters that render entities (e.g. block content) as styled card components, with a children field for nested cards.**

- **Version:** 8.x-3.x (dev checkout; branch 8.x-3.x) · **Core:** ^8.8 || ^9 || ^10 || ^11 · **Depends:** `entityreference_view_mode`
- **Field types:** `card_field_type` (default widget `card_field_widget`, formatter `card_field_formatter`); `card_children_field_type` (default widget `card_children_field_widget`, formatter `card_children_field_formatter`).
- **Services:** `cache_context.card` (`Cache/Context/CardCacheContext`, tagged `cache.context`).
- **Hooks:** `cards_entity_view_alter` / `cards_entity_build_defaults_alter` wrap card entities in a container and add the `card` cache context; `cards_theme` registers card templates (`templates/`).
- **Routes/permissions:** none.
- **Security:** no routes or endpoints; a field/display provider only. Nothing security-relevant.

See [configure/fields.md](configure/fields.md)
