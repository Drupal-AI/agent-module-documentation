# cshs — agent start

Client-side hierarchical select for taxonomy terms: one dropdown per level, revealed as you
drill down. Provides a `cshs` form element, a `cshs` field widget (entity_reference →
taxonomy), four field formatters, Views term filters, and Twig templates. Depends on core
`field` + `taxonomy`. No admin page or permissions — configure per field via Manage form
display / Manage display.

- Field **widget** + its settings (lineage, force-deepest, parent, level labels) → [configure/widget.md](configure/widget.md)
- Field **formatters** (full / flexible hierarchy, group-by-root, specific level) → [configure/formatters.md](configure/formatters.md)
- Use the `cshs` **render element** in custom forms → [api/form-element.md](api/form-element.md)
- Theme it (`hook_theme` + templates) → [theming/templates.md](theming/templates.md)

Also provides Views filter plugins (`cshs` taxonomy-index term filters, incl. a depth
variant) under `src/Plugin/views/filter/` and a Conditional Fields handler.
