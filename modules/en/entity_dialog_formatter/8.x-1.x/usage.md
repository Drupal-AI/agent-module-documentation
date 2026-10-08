<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Dialog Formatter is an entity reference field formatter that renders each referenced entity as a link which opens that entity in a Drupal core AJAX dialog (modal).

---

Entity Dialog Formatter adds one field formatter, "Dialog rendered entity" (plugin id `entity_reference_dialog_entity_view`), for entity reference fields. On the page the referenced entity is rendered in a chosen view mode; the rendered markup becomes a `use-ajax` link that, when clicked, opens the referenced entity rendered in a second (dialog) view mode inside a core modal or off-canvas dialog. It relies entirely on Drupal core's dialog system (`core/drupal.dialog.ajax`) and needs no third-party JavaScript library, so the modal is accessible out of the box. The formatter can open a single clicked entity or all referenced entities together in one dialog, and lets you set the dialog type, width, height, title and link class. Dialog content is served by the `entity_dialog_formatter.dialog_renderer` route, gated by the "Render entity dialog" permission, and each referenced entity is rendered respecting its own view access. It requires only core Field and works with content entities.

---

- Show an entity reference in teaser view mode on the page and open the full entity in a modal on click.
- Open a video entity in a modal when a preview image is clicked.
- Build an image gallery where clicking a thumbnail opens the full-size image in a dialog.
- Display a linked article in a modal without navigating away from the current page.
- Render a referenced product in a "card" view mode and show full details in a modal.
- Preview a referenced media item in-context inside a dialog.
- Show all referenced entities of a multi-value field together in one dialog.
- Give quick in-context detail for related content without a full page load.
- Configure the on-page view mode and the in-dialog view mode independently per display.
- Set a modal (`modal`) or non-modal dialog via the "Dialog type" setting.
- Control the dialog width and height per formatter instance.
- Set a fixed dialog title, or fall back to the entity label / field label automatically.
- Apply a custom link class (default `use-ajax`) to the generated links.
- Use a custom list theme hook to lay out multiple entities inside the dialog.
- Present taxonomy-term references with their full rendered term page in a modal.
- Open a referenced user profile in a dialog from a member listing.
- Show a referenced event's full details in a modal from a compact listing.
- Provide a "read more in place" experience for reference fields.
- Restrict who can load dialog content by granting the "Render entity dialog" permission per role.
- Combine with core view modes to reuse existing display configuration for the modal content.
- Display a case study or portfolio item in full inside a lightbox-style modal.
- Show related documents in a dialog instead of downloading or leaving the page.
- Render a referenced block or paragraph-like content entity in a modal.
- Keep users on a landing page while letting them explore linked content in modals.
