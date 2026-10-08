<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Inline Quote adds a toolbar button that marks a text selection as an inline quotation (an HTML `<q>` element), for quoting inside a sentence rather than pulling a whole paragraph out as a block quote.

---

Core's CKEditor 5 ships a block quote but nothing for the inline case, so editors reach for italics or hand-typed quotation marks that look right but carry no meaning; an inline quotation element instead gives quoted phrases real semantics that screen readers and search engines can use and that a theme can style consistently, including locale-appropriate quotation marks. The module is small and PHP-free: it declares one CKEditor 5 plugin (`inlineQuote.InlineQuote`) in `ckeditor5_inline_quote.ckeditor5.yml`, ships a prebuilt JS bundle plus a toolbar icon and admin CSS, and toggles a `<q>` element around the selection — there is nothing to configure per site beyond the toolbar and text-format settings. To use it, enable the module, then at **Configuration → Content authoring → Text formats and editors** edit a CKEditor 5 format and drag the **Inline quote** button into the active toolbar for each format that should have it, and make sure that format's allowed-HTML list permits `<q>`. That last step is the one people miss: with a restricted format that does not allow `<q>`, the markup is stripped on save and the button appears to do nothing.

---

- Mark a quotation inside a sentence.
- Quote a phrase without breaking the paragraph into a block quote.
- Give quoted text real `<q>` semantics instead of italics.
- Style quotations consistently from the theme.
- Render locale-appropriate quotation marks via CSS.
- Improve screen-reader handling of quoted phrases.
- Add the Inline quote button to selected text formats only.
- Give editors a quoting tool that survives copy-paste cleanup.
- Distinguish quoted text from emphasised text.
- Quote a source inline within an article body.
- Support editorial style guides that require semantic quotes.
- Keep quotation markup out of manual source (HTML) editing.
- Replace hand-typed quotation marks in body copy.
- Verify a text format allows the `<q>` element before rollout.
- Add the plugin to a restricted format deliberately by allowing `<q>`.
- Audit which text formats expose the inline quote button.
- Toggle a quotation off again on an already-quoted selection.
- Provide consistent inline-citation markup across a multilingual site.
