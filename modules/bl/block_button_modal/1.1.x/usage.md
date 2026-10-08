Block Button Modal renders a placed block as a button that opens the block's own content in a core modal dialog.

---

Block Button Modal is a lightweight display helper for core's Block layout system. For any block placed through *Structure → Block layout* (or otherwise rendered as a `block` entity / block plugin), a per-block checkbox "Show block as modal dialog" swaps the normal block output for a single button carrying the block's label. The block's content is still rendered into the page markup (inside a hidden container), and a small client-side behavior wires the button to core's `Drupal.dialog` so a click opens that content as a full-width modal. There is no admin settings page, no route, no permission, and no server round-trip when the modal opens — the dialog is opened purely client-side over content that was already rendered with the block's normal access and visibility rules. It works on Drupal 9, 10 and 11 and depends only on core's `block` module.

---

- Hide a long or secondary block (legal text, disclaimers, FAQs) behind a button and reveal it in a modal on demand.
- Turn a "Contact us" or "Newsletter signup" block into a button that pops the form open in a dialog.
- Present a promotional / CTA block as a compact button in a sidebar, expanding to full content when clicked.
- Show a cookie or privacy notice block as a button-triggered modal instead of always-visible text.
- Keep a busy sidebar tidy by collapsing help/instruction blocks into modal buttons.
- Expose a menu or navigation block as a modal launched from a button in the header.
- Display a large image or media block in a modal to save vertical space on the page.
- Offer a "Terms & Conditions" block as a modal link/button next to a form.
- Convert a social-share or "Follow us" block into a button that opens the icons in a dialog.
- Put a store-hours or location block behind a button in a compact template region.
- Reveal a video-embed block in a modal so the video only loads visually when opened.
- Show a language-selector or region-switcher block as a modal button.
- Present a "What's new" / changelog block as a button-triggered dialog.
- Give a search block a modal presentation triggered from a small button.
- Wrap a Views block (recent content, featured items) so it opens in a modal overlay.
- Use per-block control to make only selected blocks modal while leaving the rest inline.
- Provide a lightweight, dependency-free modal without installing a lightbox/JS library.
- Theme the button and modal per block using the generated template suggestions (`input__block_button_modal`, `input__block_button_modal_block_<id>`, `block_button_modal_block__<id>`).
- Keep block content indexable / present in the DOM (rendered inline, just visually behind a button) rather than lazy-loaded.
- Migrate existing placed blocks to a modal presentation by toggling one checkbox, with no reconfiguration.
