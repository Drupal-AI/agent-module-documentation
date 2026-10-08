<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views print link, route & template stamping

## Placing the link

Two Views handlers expose the same plugin `FpdiPrintViewsLink` (id `fpdi_print_views_link`):
- **Area handler** "Print" (`area_fpdi_print_views`, from `FpdiPrintViewsHooks::viewsData`) — add it
  to a view's **Header**, **Footer** or **No results (empty)** region.
- **Field handler** "Print link" (`fpdi_print_<entity_type>`, added to every entity's views data by
  `FpdiPrintHooks::viewsDataAlter`).

`FpdiPrintViewsLink::render()` builds `#type => link` to route `fpdi_print.view` with
`view_name = view id`, `display_id`, `option_id = "{areaType}-{option id}"`, and a query of the
view's exposed input plus `view_args` = the current view arguments.

### Area handler options (`defineOptions` / `buildOptionsForm`)

- `link_text` (required) — the link label (default "Download PDF").
- `display_id` (required) — which display to execute for the PDF.
- `file_pdf` — filesystem path to the template PDF (**must be PDF 1.4**; 1.5+ fails to import). May
  be an absolute path, a path relative to Drupal root, or a `public://`-scheme path.
- `file_pdf_name` — output file name (supports tokens). Blank = view inline in browser; a name =
  force download; a path+name = save server-side and download.
- `position_text` — the YAML position configuration (see below). Blank = print the rendered view
  HTML instead.
- `print_logo` — add the site logo/name/slogan as the page header (only used in the empty-YAML,
  render-the-view path).

The options form links to `/fpdi-print/validate?pdf=<file_pdf>` to preview the template and validate
YAML (Ace editor + pdf.js, `library fpdi_print/fpdi_print`).

## The print route

`fpdi_print.view` → `pdf/view/{view_name}/{display_id}/{option_id}` →
`ViewPrintController::viewPrint()` (`src/Controller/ViewPrintController.php`):

1. Loads the view, sets the display; if `view_args` is present (query, comma-split if a string) it
   calls `$this->view->setArguments()` — these feed the view's **contextual filters** (standard
   Views argument handling/validation applies).
2. `$this->view->execute()`, then `getPdfView($view, $option_id)` builds the `Pdf` object.
3. Sets PDF metadata: `SetSubject` = view description, `setKeywords` = view tag, `SetTitle` = view
   title.
4. Streams via `StreamedResponse`: if `file_pdf_name` is set it is token/Twig-resolved
   (`convertTokenValue`), `strip_tags`'d, split into dir+name, the dir `mkdir`'d if missing, and
   output with TCPDF mode `D` (download) or `FD` (save+download); otherwise `Output()` inline.

### Access (`checkAccess`)

Route requirement `_custom_access: ViewPrintController::checkAccess`. It grants access only when the
account **has `access content` AND `$view->access($display_id, $account)` is TRUE** — i.e. the PDF is
gated by the **View's own access plugin** for that display. Anonymous users can print a view only if
that view/display is itself anonymously viewable; the PDF contains exactly the rows the executed view
returns (its filters, contextual arguments and field access still apply). Ensure the source view's
access and field access are set so the PDF never exposes data the user could not otherwise see.

## Building the PDF (`getPdfView`)

- Resolves the first result row's rendered fields into `$this->dataFields` (used for Twig
  `{{ field_name }}` replacement in positions).
- Reads `position_text`, `file_pdf`, `print_logo` from the area handler config for `option_id`.
- If `position_text` is set: `Yaml::decode()` then `getPosition()` maps each entry to a page number
  (`page`, default 1). `text`/`html` entries are token/Twig-resolved; `image` entries are parsed with
  `DOMDocument` to pull `<img>` `src`/`width`/`height` (multiple images auto-shift 80pt apart).
- If `position_text` is empty: the view is rendered (`renderInIsolation`) into a single page-1 `html`
  position; view header/footer "Global text" areas become the PDF header/footer; if `print_logo`,
  the theme logo + site name/slogan form the header (`header` array with logo width from
  `getimagesize`, SVG/EPS/AI allowed).
- Fires `hook_fpdi_print_views_alter($positions, $view, $filePdfTemplate)`, then calls
  `PrintBuilder::getPdf()`.

## YAML position format

```
- x: 10          # mm from left
  y: 10          # mm from top
  text: "[site:name]"        # token
- x: 20
  y: 10
  html: "{{ field_name }}"   # Twig against first row, or raw HTML
- x: 20
  y: 40
  width: 50
  height: 10
  image: /sites/default/files/img.png   # path, fid, base64 data URI, or <img> tag
- page: 2
  pdf: /path/to/merge.pdf    # merge an entire PDF's pages
- form: "address"            # AcroForm field fill (FPDM), no x/y
  text: "My city"
```

Any extra key that matches a `set<Key>` TCPDF method (e.g. `rotation:`) is applied as
`$pdf->setRotation(value)`. See [../api/print-builder.md](../api/print-builder.md) for how each
entry is rendered and how paths/fids are resolved.
