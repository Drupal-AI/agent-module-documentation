<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block Text is the rich-text component — a formatted body of text placed as a block in a layout.

---

Every page needs prose somewhere, and in a Layout Builder site prose is a block like anything else. This is that block: a text field using the suite's text format, placed into a section and styled with utility classes.

What makes it more than a body field is where the constraints live. The text format decides what markup an editor may produce, the utility classes decide the spacing and alignment, and the section decides the width — so a paragraph of text in a narrow column and the same text full-bleed are the same component in different places rather than two components.

If a text block drops formatting, the cause is almost always the text format stripping markup rather than the component. `vlsuite_format` is where to look.

---

- Place a paragraph of prose in a layout.
- Add formatted text to a landing page.
- Constrain markup with a text format.
- Style text spacing with utility classes.
- Place the same text in a narrow or full-bleed section.
- Translate a text block.
- Reuse a shared text block.
- Revision editorial copy.
- Embed media inside body text.
- Diagnose formatting stripped on save.
- Keep prose structure consistent.
- Restrict text blocks to certain sections.
- Give editors a plain text component.
- Combine text with adjacent components.
- Audit text formats used by components.
