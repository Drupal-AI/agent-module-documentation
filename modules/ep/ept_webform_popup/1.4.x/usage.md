<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Webform Popup adds an Extra Paragraph Types paragraph that renders a button which opens an admin-selected Webform in a popup/modal when clicked.

---

EPT Webform Popup is part of the Extra Paragraph Types (EPT) family of configurable, pre-styled paragraph types. It provides one paragraph type, `ept_webform_popup`: an editor picks a Webform via an entity-reference field, sets a button label and popup options (width, form height, title, modal vs. dialog), and the paragraph renders a button that loads the Webform through Drupal's core AJAX dialog on click. It builds on the shared `ept_basic_button` widget and `ept_core` design options (spacing, borders, background, container width, button colors), so the button's look is fully configurable per instance. It depends on the EPT Basic Button, Paragraphs and Webform modules. The paragraph handles only the button-and-popup presentation; the opened Webform keeps its own access rules, handlers and validation.

---

- Add a "Contact Us" button that opens a contact Webform in a modal.
- Offer a signup or newsletter form in a popup on a landing page.
- Reveal a feedback form on click without taking over the page layout.
- Embed a support/request form as a call-to-action button inside content.
- Present a booking or enquiry Webform in a dialog next to marketing copy.
- Place the paragraph in a Paragraphs field on nodes, blocks or via Layout Builder.
- Choose between a modal popup (blocks the page) and a non-modal dialog.
- Set the popup width and an optional fixed form height (or leave height auto).
- Give the popup a custom title, or fall back to the Webform's own label.
- Customize the trigger button's text, colors, shape, size and alignment.
- Apply shared EPT design options: margins, padding, borders, background, container width.
- Reuse a single Webform across many pages, each with its own button styling.
- Build a landing-page CTA that keeps the form off-screen until requested.
- Collect leads via a promoted Webform without a dedicated form page.
- Add a quick "Ask a question" popup form to product or service pages.
- Show a survey Webform in a modal triggered from an announcement.
- Trigger a job-application or event-registration Webform from a styled button.
- Keep long forms out of the main flow, opening them on demand in a dialog.
- Combine with other EPT paragraphs to compose a full page section.
- Give content editors a no-code way to attach popup forms while authoring.
