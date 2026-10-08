# faqfield — agent start

Defines a `faqfield` field type storing an unlimited, reorderable list of question + answer +
answer-format triples. One widget (`faqfield_default`) with a selectable answer input, and five
display formatters (accordion / definition list / anchor list / details / simple text). No admin
settings page, no permissions, no routes — everything is configured on the entity's field/display
screens. Depends on core `field` and the `jquery_ui_accordion` module.

- Add an FAQ field, choose the answer widget, pick a formatter, set the answer text format
  → [configure/faqfield.md](configure/faqfield.md)
- Theme the formatter output (Twig templates + theme hooks) → [theming/faqfield.md](theming/faqfield.md)
