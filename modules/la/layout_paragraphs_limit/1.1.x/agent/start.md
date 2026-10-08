# Layout Paragraphs Limit — agent index

Restricts, per Layout Paragraphs **layout + region**, which Paragraph types may be added and
how many components a region may hold. Requires `layout_paragraphs`. No permissions of its
own (form uses core `administer site configuration`), no plugins, no Drush.

- **Configure the restrictions / config object shape / settings form** →
  [configure/settings.md](configure/settings.md)
- **How it enforces the rules at edit time (the event subscriber)** →
  [api/allowed-types-event.md](api/allowed-types-event.md)

Key fact: all rules live in the config object `layout_paragraphs_limit.settings` at
`disallowed_types.<layout_id>.<region>` → `{ negate: bool, numeric_limit: int, paragraph_types: {<ptype>: <ptype>|0} }`.
`negate` TRUE = include only the checked types; `negate` FALSE (default) = exclude the checked
types. `numeric_limit` 0 = unlimited. Real layout ids/regions come from core layouts, e.g.
`layout_onecol` (region `content`) and `layout_twocol` (regions `top,first,second,bottom`).
