<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Micromodal adds a "button with popup" block type that renders a trigger button which opens authored content in an accessible Micromodal.js dialog.

---

EBT Micromodal is part of the Extra Block Types (EBT) family and depends on `ebt_core`. Enabling it
creates a `block_content` bundle called **EBT Micromodal** with three fields: a WYSIWYG **Body**
(text_with_summary) that becomes the modal's content, a **Micromodal Title** (text_long) shown in the
modal header, and the shared **field_ebt_settings** rendered through this module's own
`ebt_settings_micromodal` widget. That widget adds Micromodal-specific options on top of the standard
EBT design options: the trigger **Button text**, the **Close Button text**, a **Disable scroll**
toggle (locks page scroll while the modal is open), and a **Display close icon** toggle for the "X".
The two `templates/block--*-ebt-micromodal.html.twig` overrides emit the trigger `<a>`, the
`.modal` markup wired with Micromodal's `data-micromodal-trigger`/`data-micromodal-close` attributes,
and attach the `ebt_micromodal` library; `js/ebt_micromodal.js` initialises Micromodal per block and
passes the disable-scroll option through `drupalSettings`. The Micromodal.js library itself is loaded
from `/libraries/micromodal/dist/micromodal.min.js` (Composer package `levmyshkin/micromodal`).

Create these blocks at Structure » Block layout » Custom block library (or inline via Layout Builder),
author the title and body, set the button/close labels, then place the block. No extra permissions,
routes, services, or Drush commands are added — it is purely a content-display/site-building block
type. It works standalone (you do not need the other EBT block modules), and inherits EBT Core's
margin/border/padding/background/container design options.

---

- Add a "button with popup" block to a page.
- Reveal secondary content in an accessible modal dialog.
- Build a Privacy Policy / Terms popup opened by a button.
- Show a call-to-action button that opens more information.
- Present media or an embedded form inside a modal.
- Configure the trigger button label per block.
- Customise the modal's close-button label.
- Lock page scrolling while the modal is open (Disable scroll).
- Toggle the "X" close icon in the modal header.
- Author the modal title with a text field.
- Author the modal body with the WYSIWYG editor.
- Place the block through Layout Builder as an inline block.
- Place the block through the standard Block layout UI.
- Add an accessible popup without writing custom JavaScript.
- Apply EBT Core design options (margin, border, padding) to the block.
- Set a background color or image on the popup block via EBT settings.
- Use Micromodal.js for lightweight, dependency-free modals.
- Add multiple independent modal blocks on one page.
- Provide on-demand "read more" details behind a button.
- Build a cookie/consent-style informational popup.
- Use the block standalone without other EBT modules.
- Translate the modal title and body per language.
