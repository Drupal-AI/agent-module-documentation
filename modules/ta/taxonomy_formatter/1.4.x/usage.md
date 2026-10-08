Taxonomy Formatter provides a single field formatter ("Taxonomy Formatter") for entity-reference fields that reference taxonomy terms, letting you render the referenced terms inline with a configurable separator, an optional per-term HTML element, an optional wrapper element, CSS classes, and optional links to the term pages.

---

The module registers one field formatter plugin, `taxonomy_term_reference_formatter` (label "Taxonomy Formatter"), applicable to `entity_reference` fields (typically term-reference fields). Its per-instance settings (configured on *Manage display* → the field's gear icon) are: `links_option` (render terms as links to their term page vs. plain text), `separator_option` (a string, default `", "`, including leading/trailing spaces), `element_option` (wrap each term in a chosen HTML element such as span/h1–h5, or none), `element_class`, `wrapper_option` (wrap the whole collection in div/span/p/etc., or none), and `wrapper_class`. `viewElements()` loads the referenced entities via `getEntitiesToView()` and concatenates each term's label (escaped with `Html::escape`, or `$entity->toLink()` when links are on) wrapped in the element tag, joined by the escaped separator, then optionally wrapped; classes are run through `Html::cleanCssIdentifier()`. The result is emitted as a single `#markup` string. The module provides no config schema, no permissions, no admin page, and no Drush; it is enabled and then selected as the display formatter per field. (Note: the element-option select has two cosmetic label bugs — "h6"/"h7" options actually map to `strong`/`em` tags.)

---

- Display a node's tags inline separated by commas on the full/teaser view.
- Render term-reference values as links to each term's page.
- Show terms as plain text (no links) where linking is undesirable.
- Use a custom separator such as " | ", " / ", or " • " between terms.
- Wrap each term in a `<span>` so it can be styled as a pill/badge.
- Wrap each term in a heading element for a prominent category label.
- Add a CSS class to every term element for theming.
- Wrap the entire term list in a `<div>` or `<p>` container.
- Add a CSS class to the wrapper element for layout/styling hooks.
- Render a single-value term reference as a styled label.
- Present a multi-value taxonomy field as a compact delimited string.
- Style category terms as inline tags without writing a custom formatter or template.
- Control leading/trailing spacing around the separator precisely.
- Output term labels safely escaped to avoid markup injection from term names.
- Build a breadcrumb-like row of terms using a " › " separator.
- Combine wrapper + element + classes to match an existing design system's tag markup.
- Replace the core "Label" taxonomy formatter when you need separators or wrappers.
- Apply different separators/wrappers per view mode (teaser vs. full).
- Show product attributes stored as term references as an inline styled list.
