Submodule of USWDS Paragraph Components that installs a USWDS **process list** paragraph type — a numbered list of steps rendered as `usa-process-list` markup.

---

Enabling this submodule imports two bundles: `uswds_process_list` (the container) and `uswds_process_item` (one step). `uswds_process_list` holds `field_process_items` (a nested Paragraphs field of process items). Each `uswds_process_item` has `field_header` (the step heading) and `field_text` (the step body). The template `paragraph--uswds-process-list.html.twig` renders an `<ol class="usa-process-list">` and loops the items, emitting `<li class="usa-process-list__item">` with an `<h4 class="usa-process-list__heading">` and the item text rendered via the formatter (`field_text|view`). No CSS library is shipped — styling comes from the theme's USWDS assets. Expose only `uswds_process_list` on your Paragraphs field.

---

- Present a step-by-step process (application, onboarding, how-to) as a numbered USWDS list.
- Give each step a heading and a rich-text description.
- Document a multi-stage government service flow.
- Add or reorder steps by editing the nested process items.
- Show ordered instructions with consistent USWDS styling and numbering.
- Embed a process list inside body content via a Paragraphs field.
- Nest a process list inside a columns layout.
- Render step bodies through their text formatter for safe formatted output.
- Override `paragraph--uswds-process-list.html.twig` to change heading level or markup.
- Reuse a standardized process-list component across a federal site.
- Combine a process list with alerts or summary boxes on the same page.
- Build a checklist-style walkthrough without hand-building the bundle.
- Explain a benefits or eligibility determination as sequential stages.
- Provide numbered how-to instructions with a consistent federal look.
- Break a complex task into clearly headed, ordered steps.
