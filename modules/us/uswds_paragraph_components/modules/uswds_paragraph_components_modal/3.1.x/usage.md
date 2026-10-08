Submodule of USWDS Paragraph Components that installs a USWDS **modal** paragraph type — a dialog opened from a link or button and rendered as `usa-modal` markup.

---

Enabling this submodule imports the `uswds_modal` bundle plus its fields and displays. Fields: `field_modal_title`, `field_modal_body`, `field_button_text` (the trigger label), `field_display_as_button` (bool — render the trigger as a `usa-button` vs an unstyled link), `field_large_modal` (bool → `usa-modal--lg`), `field_force_action` (bool → `data-force-action`, hides the X close so a footer choice is required), plus `field_modal_yes_button_text` / `field_modal_no_button_text` (footer button labels, defaulting to translated "Yes"/"No"). The template `paragraph--uswds-modal.html.twig` outputs the trigger anchor (`data-open-modal`, `aria-controls`) and the `usa-modal` dialog with heading, body, a `usa-button-group` footer and (unless force-action) a close button. Modal open/close behavior comes from the USWDS JavaScript your theme provides; a `uswds-modal` CSS shim is attached in non-preview view modes. Expose `uswds_modal` on your field.

---

- Add a modal dialog triggered by a link or button within page content.
- Render the trigger as a prominent USWDS button or a subtle unstyled link.
- Show a large modal for more content with the large-modal option.
- Force the user to choose a footer action by hiding the close button (force-action).
- Provide Yes/No (or custom-labeled) confirmation buttons in the modal footer.
- Present terms, disclaimers or confirmations before proceeding.
- Give the modal an accessible heading and description (aria-labelledby/aria-describedby wired).
- Embed a modal inside body content via a Paragraphs field.
- Reuse the modal component across pages with consistent USWDS styling.
- Localize the default Yes/No button text automatically.
- Override `paragraph--uswds-modal.html.twig` to adjust the dialog markup or icon.
- Combine a modal trigger with other components on the same page.
- Standardize modal dialogs on a federal site without hand-building the bundle.
- Attach the modal CSS shim only on the front end (preview view mode excluded).
- Collect a simple yes/no decision before a user proceeds with an action.
- Surface supplemental help or policy text on demand without cluttering the page.
