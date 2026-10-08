<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cards provides field types, widgets and formatters that turn entities — typically block content — into styled “card” components, including a card field and a card-children field for nesting cards inside a parent card.

The module ships two field types: `card_field_type` (marks an entity as a card, with its own widget/formatter and a themed wrapper) and `card_children_field_type` (references child entities to render as nested cards, using the `entityreference_view_mode` dependency to pick a view mode). `hook_entity_view_alter`/`hook_entity_build_defaults_alter` wrap rendered card entities in a container and add a `card` cache context (via the `cache_context.card` service) so card rendering can vary per card. Templates in `templates/` provide the card markup.

Typical setup: enable the module (and `entityreference_view_mode`), add a Cards field to a block-content (or other entity) type to make it a card, optionally add a Cards Children field to reference sub-cards, and configure the display.

---

Short summary: field-based card components (with nested child cards) for entities like block content.

It solves building reusable card UIs without hand-writing markup per entity: attach the card field to make an entity render as a card, and the children field to compose cards into groups/grids. It works via field-type/widget/formatter plugins plus entity view alters and a dedicated cache context.

Operationally there are no routes or permissions — it is a field/display provider. It depends on `entityreference_view_mode` for choosing the view mode of referenced child cards. Rendering adds a `card` cache context so cached output stays correct across card variations.

---

- Turn a block-content type into a card by adding the Cards field.
- Add a Cards Children field to nest child cards in a parent card.
- Render entities as styled card components.
- Choose the view mode used for referenced child cards.
- Build card grids/rows from block content.
- Attach the card widget on the form display.
- Format an entity as a card on the view display.
- Wrap card entities in a container automatically.
- Vary cached card output with the `card` cache context.
- Compose reusable card-based layouts without custom markup.
- Use provided card templates for consistent markup.
- Reference multiple children to build a card group.
- Combine with Layout Builder or blocks to place cards.
- Theme cards by overriding the module's templates.
- Add card fields to content types other than block content.
- Build landing pages from card components.
