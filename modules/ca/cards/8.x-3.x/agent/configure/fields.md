<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Cards

Cards is a field/display provider — there is no admin settings page. Requires `entityreference_view_mode`.

## Make an entity a card
1. On a bundle (commonly a **block content** type), add a field of type **Cards** (`card_field_type`).
2. On the **Manage form display**, use the card widget (`card_field_widget`).
3. On **Manage display**, use the card formatter (`card_field_formatter`).

When such an entity is rendered, `cards_entity_view_alter()` wraps it in a `container` theme wrapper and `cards_entity_build_defaults_alter()` adds the `card` cache context, so cached output varies correctly across cards.

## Nested child cards
Add a field of type **Cards Children** (`card_children_field_type`) to reference other entities; its widget/formatter (`card_children_field_widget` / `card_children_field_formatter`) render the referenced entities as nested cards. The **view mode** for children comes from the `entityreference_view_mode` integration.

## Theming
Override the templates in the module's `templates/` directory (registered via `cards_theme()`) to control card markup.
