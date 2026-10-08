# Configuration

All of Printable's settings live in one config object and are edited under
**Configuration → User interface → Printable**
(`/admin/config/user-interface/printable`), which requires the **Administer
printable** permission. The main page is split across a few sub‑forms.

## The settings forms

| Page | Path | What it covers |
|---|---|---|
| **Printable** (main) | `/admin/config/user-interface/printable` | Which entity types/bundles are printable, plus general options |
| **Print format** | `…/printable/print` | Options for the printer‑friendly HTML output |
| **PDF format** | `…/printable/pdf` | PDF toolkit and PDF‑specific options |
| **Print links** | `…/printable/links` | Which entity types show a **Print** link |
| **PDF links** | `…/printable/links/pdf` | Which entity types show a **PDF** link |

## Choose which content is printable

On the main form, set **which entity types get a printable version**. By default
this is **nodes, comments, and users**. Only entity types listed here get a
printable route (like `/node/{nid}/printable/print`) and a `printable` view mode.
You can also restrict which **bundles** of each type are printable (for example,
only Articles).

Note that being *printable* (having the route) is separate from *showing a link* —
you control the links independently below.

## Place the Print and PDF links

- On the **Print links** form, choose the entity types on which a **Print** link is
  shown (default: nodes). 
- On the **PDF links** form, choose where a **PDF** link is shown.

Links are injected into the entity's output automatically. Alternatively you can
place the **Printable Links Block** in a region (via **Structure → Block layout**)
to render the Print/PDF links for the current entity wherever you want them.

There is also an option to open the Print/PDF links in a **new tab**, and an option
to **omit the Print/PDF links from the printable page itself** (on by default, so
the clean page doesn't show its own links).

## Tune the printer‑friendly (Print) output

On the Print format form and the main form you can:

- **Include a canonical link** — add a canonical `<link>` in the printable page for
  reference/SEO (on by default).
- **Handle in‑content links** — choose how hyperlinks inside the content are
  treated in print output, via a *link extractor*:
  - **None** — leave links as they are.
  - **Remove** — strip the link, leaving just the text.
  - **Extract** — show the URL in brackets after the link text.
  - **Subscript** — render the link reference as a subscript.
- **Add a custom CSS file** to style the printable/PDF output.
- **Send to printer** — automatically open the browser's print dialog when the
  printable page loads, and optionally **close the window** after printing.

## PDF output

PDF requires the **printable_pdf** submodule (see
[Installation](../installation/index.md#submodule--printable_pdf-for-pdf-output))
and a **PDF toolkit** selected through PDF API. On the PDF format form you set:

- **PDF toolkit** — which engine renders the PDF (wkhtmltopdf, TCPDF, mPDF, or
  dompdf). If no toolkit is selected, the PDF format is unavailable and its links
  are hidden.
- **Paper size** — e.g. A4 (default) or Letter.
- **Page orientation** — Portrait (default) or Landscape.
- **Download vs. inline** — whether the PDF is downloaded as an attachment or shown
  inline in the browser.
- For wkhtmltopdf specifically, there are advanced options for the binary path and
  running it under Xvfb.

Images in PDFs are served with absolute, tokenless paths via the module's
`printable://` stream wrapper, so they resolve correctly in the generated file.

## Permissions

Printable adds two permissions on **People → Permissions**:

- **Administer printable** — reach the settings forms above. Give this to trusted
  admin roles.
- **View printer friendly versions** — view any printable page. Grant this to the
  roles (or **anonymous**) who should be able to print/download content. It is
  combined with normal view access on the entity itself.

## Theming

The printable page is rendered through the `printable`, `printable_header`, and
`printable_footer` templates, and print‑specific `*__printable` theme suggestions
let a theme give fields or entities a dedicated print layout. See the
[`agent/`](../agent/start.md) theming docs for details.
