# Printable PDF (printable_pdf) — agent index

Submodule of **Printable** that adds the `pdf` output format (a `PrintableFormat` plugin,
`PdfFormat`) so content entities can be rendered as PDF via `pdf_api`. No config object or
settings form of its own — it reads the parent's **`printable.settings`**.

- **How PDF generation works, the config keys it reads, the pdf route, theme hooks** →
  [configure/pdf.md](configure/pdf.md)

Key facts:
- Adds `/{entity_type}/{entity}/printable/pdf` (format id `pdf`), e.g. `/node/{nid}/printable/pdf`.
- Depends on `printable` + `pdf_api`; the PDF engine is `printable.settings.pdf_tool`
  (`wkhtmltopdf` / `tcpdf` / `mpdf` / `dompdf`). No `pdf_tool` → error + 404.
- `save_pdf` TRUE = download (attachment); FALSE = inline. PDF links controlled by
  `printable.settings.printable_pdf_link_locations`.
- PDF options are edited on the parent forms: `/admin/config/user-interface/printable/pdf`
  and `/admin/config/user-interface/printable/links/pdf`.
- Registers `printable_pdf_header` / `printable_pdf_footer` theme hooks.
