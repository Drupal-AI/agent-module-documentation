<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Collection Statement renders a statement or pull quote — a short passage given visual prominence.

---

The statement covers a family of uses that share a shape: a testimonial, a pull quote from an article, a mission statement, a headline figure. Each is a short piece of text that should stand out from the prose around it, usually with an attribution.

Having it as a component rather than as styled text in a body field matters for the same reason `ckeditor5_inline_quote` matters at the inline level: a quotation marked up as a quotation carries meaning, can be styled consistently, and can be found later. Text made large and italic in a WYSIWYG is none of those things.

The attribution is worth getting right. A testimonial without a name is worth little, and a quotation attributed in a separate paragraph is not associated with the quote for anyone using assistive technology. A component with a dedicated attribution field solves both, provided the template renders it with the right relationship — `blockquote` with `cite`, or an equivalent.

---

- Show a customer testimonial.
- Pull a quote out of an article.
- Display a mission statement.
- Highlight a headline figure.
- Attribute a quotation to a source.
- Mark up a quotation semantically.
- Style statements consistently.
- Avoid large italic text in a body field.
- Associate an attribution with its quote.
- Translate a statement and its attribution.
- Save a statement to the section library.
- Place a statement between prose sections.
- Audit quotations for attribution.
- Check the statement's markup semantics.
- Reuse a testimonial across pages.
