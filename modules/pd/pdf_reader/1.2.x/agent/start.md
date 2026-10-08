<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF Reader — agent index

Adds one field formatter, `FieldPdfReaderFields` ("PDF Reader"), that renders a PDF in a
`file`, `string`, or `uri` field as an inline viewer. No admin settings page or config
route — it is configured per field on *Manage display*. Defines the permission
"administer pdf reader". No dependencies beyond core (Colorbox + Libraries optional).

- **Select the formatter, renderers, and every setting key** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id: `FieldPdfReaderFields`; field types: `string`, `file`, `uri`.
- Renderers (`renderer` setting): `google`, `ms`, `embed`, `pdf-js`, and `colorbox`
  (only when Colorbox + Libraries modules are enabled).
- Settings (on the display component): `pdf_width` (600), `pdf_height` (780),
  `renderer` (`google`), `embed_view_fit` (`Fit`/`FitH`/`FitV`), `embed_hide_toolbar`,
  `download`, `link_placement` (`top`/`bottom`).
- Templates: `pdf_reader`, `pdf_reader_embed`, `pdf_reader_js`, `pdf_reader_colorbox`.
