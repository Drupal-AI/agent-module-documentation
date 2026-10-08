Submodule of Field Group that adds "Accordion" and "Accordion item" group formats, rendering grouped fields as a jQuery-UI accordion. It is deprecated because jQuery UI is end-of-life.

---

`field_group_accordion` extends the parent Field Group module with two extra `FieldGroupFormatter` plugins: **Accordion** (the outer container) and **Accordion item** (each collapsible section). You place an Accordion group on a **Manage form display** or **Manage display** and nest Accordion item groups inside it, giving editors and site visitors collapsible, one-open-at-a-time sections. It uses the core `jquery_ui_accordion` module for the widget and ships its own render elements (`src/Element/Accordion.php`, `AccordionItem.php`) and Twig templates. Per-item settings include the label and default open state, and the container settings control effects. Because jQuery UI is EOL, the module is flagged **deprecated** (`lifecycle: deprecated`); new sites should prefer the Details or Tabs formats from the parent module. It remains available for existing sites that still rely on the accordion look.

---

- Render a set of node fields as a collapsible accordion on the edit form.
- Group display fields into one-open-at-a-time accordion sections on the front end.
- Add an "Accordion" container group, then nest "Accordion item" groups inside it.
- Provide an FAQ-style stacked/collapsible layout from grouped fields.
- Collapse rarely used field sections to shorten a long editor form.
- Give each accordion item its own heading label.
- Set which accordion item is open by default.
- Combine accordion items with other Field Group formats in the same display.
- Reduce visual clutter on media or paragraph forms with collapsible sections.
- Keep an existing D7-style accordion layout working after upgrade.
- Export accordion group config with the rest of the display configuration.
- Theme accordion output by overriding `field-group-accordion*.html.twig`.
- Apply the accordion to any entity type that uses Field UI.
- Offer progressive disclosure of optional content sections.
- Migrate legacy accordion field groups forward (then plan a move off jQuery UI).
