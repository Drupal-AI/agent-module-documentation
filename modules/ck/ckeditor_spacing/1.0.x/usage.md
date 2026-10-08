<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Spacing lets editors set margin and padding on individual block elements (paragraphs, headings, images, and more) from a balloon in CKEditor 5, without ever enabling the risky `style` attribute on the text format.

The editor stores the chosen spacing as a data attribute on the block; a text-format filter (`SpacingFilter`) then converts that data attribute into an inline style at render time. Because the `style` attribute itself is never allowed through the format, the format stays XSS-safe while still producing inline spacing. Setup is: add the "Spacing" button to the CKEditor toolbar, then enable the "Apply spacing to block elements" filter ordered after "Limit allowed HTML tags". The filter's XPath runs against a controlled set of spacing data-attributes, not arbitrary user CSS.

Use it to give editors controlled block spacing without opening up inline styles across the whole editor.
---
Set margin/padding on individual blocks from a CKEditor 5 balloon, storing it as a data attribute converted to inline style by a filter.
---
- Add margin to a paragraph from a CKEditor balloon
- Add padding to a heading block
- Space out an image within rich text
- Give editors block spacing without enabling inline styles
- Keep the text format XSS-safe (no style attribute)
- Store spacing as a data attribute on the block
- Convert the data attribute to inline style via the filter
- Add the "Spacing" toolbar button to a format
- Order the spacing filter after "Limit allowed HTML tags"
- Apply consistent spacing controls across block types
- Avoid custom CSS classes for one-off spacing
- Fine-tune vertical rhythm inside body content
- Let editors nudge element spacing visually
- Restrict spacing to a controlled attribute set
- Improve layout of editorial content without templates
