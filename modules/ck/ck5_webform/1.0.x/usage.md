<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Webform Embed adds a toolbar button/widget to insert a Webform into rich text, plus a text-format filter that renders the chosen form when the content is viewed.

---

The module gives editors a native CKEditor 5 widget (the "Embed Webform" toolbar button) that opens an AJAX modal listing every open webform; picking one inserts a `<drupal-webform data-webform-id="...">` tag into the markup and shows a dashed-box placeholder in the editor. On display, the `filter_ck5_webform` text-format filter (`WebformFilter`) rewrites that tag into the live webform by loading the entity and rendering its submission form through Webform's own view builder. Editors double-click a placeholder to re-open the modal and swap the form. There is no settings form and no permissions of its own — you enable the toolbar button and the filter on each text format. The embedded form is rendered by the Webform system, which enforces its own access rules, handlers and submission logic; this module only injects the render.

---

- Let editors drop a contact/registration/survey webform directly into an article body.
- Add a rich-text "Embed Webform" button to Basic HTML or Full HTML CKEditor 5 toolbars.
- Insert a webform inline in any text field that uses a CKEditor 5 text format.
- Browse and pick an open webform from an AJAX modal without leaving the edit page.
- Show a labelled placeholder box in the editor marking where the form will render.
- Double-click an embedded placeholder to swap it for a different webform.
- Render a selected webform on the frontend via the `filter_ck5_webform` filter.
- Keep the source markup semantic and portable as a `<drupal-webform data-webform-id>` tag.
- Reuse the same webform in multiple pages by embedding its machine ID.
- Place a newsletter signup form mid-article between paragraphs.
- Embed an event RSVP form inside a landing page's body copy.
- Add a feedback form to a documentation page's rich text.
- Offer a support/ticket webform inside a knowledge-base node body.
- Insert a donation form into a campaign page's editorial content.
- Let non-technical authors add forms without writing HTML or shortcodes.
- Limit the embed picker to "open" webforms so closed/scheduled forms are not offered.
- Auto-clear cached pages when an embedded webform is edited (webform cache tags are attached).
- Restrict which formats allow embedding by enabling the filter per text format only.
- Combine with "Limit allowed HTML tags" by whitelisting `<drupal-webform data-webform-id>`.
- Rely on the webform's own access rules and handlers for submission handling.
- Present a contextual modal title ("Edit Webform: X" vs "Embed Webform") when editing an existing embed.
