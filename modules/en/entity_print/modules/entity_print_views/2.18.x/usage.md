Entity Print Views is the Views companion to Entity Print: it renders an entire View's results to PDF (or another export type) instead of a single entity.

---

This submodule of Entity Print extends the print pipeline to Views. It registers the `view`
entity as printable and provides two Views handlers: a **global "Print" area** handler you add to
a view's header or footer to render a link that prints the whole display, and a per-row **"Print
link" field** that prints the individual entity of that row. The print route is
`print/view/{export_type}/{view_name}/{display_id}`, with a `/debug` variant to inspect the raw
HTML. It reuses the parent module's engines, export types, CSS handling, and settings form, so
the same Dompdf/Wkhtmltopdf/TCPDF configuration applies. Access is gated by its own
`entity print views access` permission. The row-level field supports an export-type setting and an
"open in new window" option. Requires the core Views module and the base `entity_print` module.

---

- Add a "Print this list" button to the header of a report View.
- Export a directory or catalog View to a single PDF.
- Produce a printable roster or attendee list from a View.
- Generate a PDF price list from a products View.
- Offer a per-row "Print" link that prints just that row's entity.
- Let editors download a filtered content listing as a PDF.
- Print a calendar or schedule View for offline use.
- Create a printable financial or analytics summary from a View.
- Provide a "Download as PDF" footer link on a search-results View.
- Print a View to EPub or Word instead of PDF via the export-type setting.
- Open the printable View in a new browser tab from the row link.
- Debug a View's print HTML at the `/debug` route before styling.
- Reuse the site's configured print engine and paper settings for Views output.
- Restrict printable Views to specific roles with the views-access permission.
- Generate board or committee packet PDFs from a curated View.
- Export a membership or subscriber list to PDF for mailing.
- Print an invoice-line or order-items View as a document.
- Provide printable exhibitor or vendor lists at events.
- Turn a tabular data View into a shareable PDF report.
- Bundle multiple entities shown in a View into one printable document.
