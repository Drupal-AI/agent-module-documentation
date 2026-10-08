# FPDI Print — manual setup guide

**FPDI Print** (`fpdi_print`) lets a **View** print onto an existing PDF template,
overlaying your content's data onto a ready‑made document. It's built for the common
need to generate filled PDFs — certificates, letters, forms — from a template plus
some dynamic data, without hand‑coding a PDF generator. Under the hood it uses the
FPDI and TCPDF libraries, which Composer installs for you.

You drive it from Views. A typical setup is a View **page** with a contextual filter
(for example the node id) that adds a **Pdf Print (global)** area to the view's
header or footer. In that area you point the module at a source PDF template and
describe where each piece of content should go — either by giving explicit x/y
positions (and text/HTML/image) in a small YAML block, or, if you leave positions
empty, by letting it print the view's rendered contents. If your template is a
fillable PDF form (FPDM‑compatible), you can address form fields by name instead of
coordinates, so you don't need x/y positions at all.

Two practical cautions. First, the template must be a **PDF version 1.4** document —
FPDI in this configuration does not handle version 1.5 or 1.6 templates. Second, and
more importantly, remember that a printed PDF should never contain data the viewer
couldn't otherwise see: the data placed on the PDF comes from the view, so confirm
the view's field access is correct, and serve the generated PDFs (which may contain
personal data) with appropriate access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (this also brings in
   the FPDI and TCPDF libraries) and enable the module.

FPDI Print has **no central settings page**. Its configuration lives on each View
that uses it, described in "How to use it" below.

## Where it lives in the admin menu

There is no module settings form. You configure PDF printing from **Structure →
Views** (`/admin/structure/views`) on the individual View. The module also provides a
validation helper page at **`/fpdi-print/validate`** where you can check a PDF and
your YAML position format before pasting them into the View.

## How to use it

1. Create a **View page** for the content you want to print — for a single record,
   add a **contextual filter** such as the node id so the view targets one item.
2. Add the **Pdf Print (global)** area to the view's **Header** or **Footer**.
3. Fill in its configuration:
   - **Path to the PDF source file** — the template to print onto. Use an absolute
     path (for example `/var/www/drupal/sites/default/files/template.pdf`) or a
     relative one (`sites/default/files/template.pdf`). Confirm the template is
     **PDF 1.4** — 1.5/1.6 files will not work.
   - **Positions** — a YAML block describing where content goes. Positions are keyed
     by page number (starting at **1**, not 0), each listing entries with `x`, `y`
     and a `text`, `html`, or `image`. For a fillable (FPDM) form, use
     `form:`/`text:` pairs and skip the x/y coordinates. Leave positions **empty** to
     simply print the view's rendered contents (and you can set header/footer text
     from the Views header/footer global custom text areas).
4. Check your PDF and YAML at **`/fpdi-print/validate`** before pasting, then save the
   View and load the page to generate the document.

> **For developers:** the module fires a `hook_fpdi_print_views_alter()` so you can
> adjust the data positions before the PDF is generated, and it exposes a
> `fpdi_print.print_builder` service (`->getPDF($positions, $templatePath)`) if you
> want to build PDFs from your own code.
