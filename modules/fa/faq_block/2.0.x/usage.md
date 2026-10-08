<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FAQ Block provides a custom block plugin for assembling a Frequently Asked Questions section. A site builder adds question/answer items (with a rich-text answer), an optional section title and description, and a toggle icon color, then places the block; the front end renders an expand/collapse accordion.

---

- Requires core `block`; Drupal 10.
- Enable with `drush en faq_block`, then place the "FAQ Block" via Block Layout or Layout Builder.
- In the block configuration form, add FAQ items with the "Add FAQ Item" / "Remove FAQ Item" AJAX buttons.
- Each item has a question (autocomplete-assisted custom element) and a rich-text answer (text_format).
- Set an optional section title, section description, and a color for the toggle (plus/minus) icon.
- Files embedded in answers are registered for file usage automatically on save.

---

- Build an FAQ accordion without writing code.
- Add an arbitrary number of question/answer pairs per block.
- Author answers with the CKEditor rich-text editor.
- Give the FAQ section a title and intro description.
- Customize the expand/collapse icon color.
- Reorder items (draggable custom element).
- Place multiple independent FAQ blocks on different pages.
- Track file usage for images/files embedded in answers.
- Promote temporary embedded files to permanent on save.
- Use within Layout Builder or classic Block Layout.
- Empty items (blank question) are pruned on submit.
- Render via the `faq_block` theme hook (overridable template).
- Attach the module's accordion JS/CSS library automatically.
- Provide a lightweight alternative to full FAQ content types.
- Keep FAQ content as block configuration (exportable).
- Support per-block section styling.
