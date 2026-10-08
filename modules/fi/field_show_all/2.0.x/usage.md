Field Show All collapses a multi-value field to the first N items with "show all" / "show less" toggle links.

---

Field Show All augments any existing field formatter (not a formatter plugin of its own) by adding third-party settings that appear only on unlimited-cardinality fields. When enabled on a field's view display, it renders only the first N delta items, hides the rest with CSS, and appends a clickable text link that expands the full list on click and toggles back to the collapsed view. The toggle is driven by a small jQuery behavior and per-field values passed through drupalSettings. It is a pure display enhancement based on Field Load More, with no content entities, routes, services, or plugins of its own, and supports Drupal 8 through 11.

---

- Collapse a long multi-value text field to the first few items on a node view.
- Show a "Show all" text link when a field has more items than the configured limit.
- Toggle the same link back to "Show less" after expanding.
- Keep an unlimited-cardinality tags/reference/text field compact by default.
- Set a per-field limit (number of items shown before collapsing).
- Customize the expand link text (e.g. "Show all 42 items").
- Customize the collapse link text (e.g. "Show fewer").
- Apply different limits and link labels per view mode (default, teaser, etc.).
- Reduce vertical space taken by fields with many delta values.
- Improve display density on entity pages with long repeating fields.
- Enable the toggle only on the view modes where the field is long.
- Present a preview of list items with an on-demand reveal of the rest.
- Avoid pagers for medium-sized multi-value fields.
- Combine with any base formatter that renders one markup item per delta.
- Provide progressive disclosure for multi-value fields without custom code.
- Add expand/collapse behavior via configuration only, no theming required.
- Shorten teaser displays that would otherwise list every field value.
- Give editors control of display length without limiting stored data.
- Keep entity displays scannable when fields can hold dozens of values.
- Offer a lighter-weight alternative to Field Load More using text links.
