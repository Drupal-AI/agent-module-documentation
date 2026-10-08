Submodule of USWDS Paragraph Components that installs a USWDS **step indicator** paragraph type — a progress tracker for multi-step flows rendered as `usa-step-indicator` markup.

---

Enabling this submodule imports `uswds_step_indicator_list` (the container) and `uswds_step_indicator_item` (one step). The container holds `field_step_indicator_items` (nested steps), `field_header` (heading text), and boolean options `field_centered` (→ `usa-step-indicator--center`), `field_counters` (→ `usa-step-indicator--counters`), `field_small_counters` (→ `usa-step-indicator--counters-sm`) and `field_no_labels` (→ `usa-step-indicator--no-labels`). Each `uswds_step_indicator_item` has `field_item_title` and `field_current` (bool marking the current step). The template `paragraph--uswds-step-indicator-list.html.twig` walks the items: the first item flagged `field_current` becomes the "current" segment, earlier items are marked `--complete`, later ones incomplete, and it renders the "Step X of N" heading counter. A `uswds-step-indicator-list` CSS shim is attached in non-preview view modes. Expose only `uswds_step_indicator_list` on your field.

---

- Show progress through a multi-step application or checkout flow.
- Label each step and mark which one the user is currently on.
- Display "Step X of N" progress text automatically.
- Use numbered counters on each step with the counters option.
- Use small counters for a more compact indicator.
- Center the step indicator with the centered option.
- Hide step labels for a minimal dots-only indicator.
- Automatically mark earlier steps complete and later steps incomplete.
- Provide accessible progress semantics (aria-current on the active step, screen-reader labels).
- Embed a step indicator at the top of a wizard-style page via a Paragraphs field.
- Reorder or add steps by editing the nested step items.
- Override `paragraph--uswds-step-indicator-list.html.twig` to customize markup.
- Reuse a standardized progress indicator across a federal site.
- Load the step-indicator CSS shim only on the front end (preview excluded).
- Pair a step indicator with a matching process list to guide a multi-page form.
- Communicate how much of an application remains before the user starts.
