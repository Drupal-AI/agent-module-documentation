# Configuration

There are two things to configure: the **formatter on each File field** (this is where
you spend most of your time), and an optional **global custom-viewer** setting.

## Choose a formatter on Manage display

The PDF viewer is applied per field, per view mode:

1. Make sure your content type has a core **File** field that allows the `pdf`
   extension. (Add one under **Manage fields** if needed.)
2. Go to the bundle's **Manage display** screen — for example **Structure → Content
   types → Article → Manage display** (or a specific view mode such as *Teaser*).
3. In the **Format** column for your file field, choose one of:
   - **PDF: Default viewer of PDF.js** — the full embedded viewer.
   - **PDF: Display the first page** — a first-page canvas thumbnail.
   - **PDF: Continuous scroll (experimental)** — all pages stacked (short docs only).
4. Click the cog to set that format's options (below), then **Update** and **Save**.

Remember you can use a different format in each view mode — a thumbnail in teasers, the
full viewer on the full page.

### Options for "Default viewer of PDF.js"

- **Always use pdf.js** — when on, everyone gets the pdf.js viewer. When off, the
  module hands the file to the browser's own PDF plugin (like Acrobat) if one is
  present, and falls back to pdf.js otherwise. The page/zoom/pagemode options below
  only apply when this is on.
- **Width** and **Height** — the iframe size, e.g. `100%` wide and `800px` tall.
  Use these to fit the viewer into a sidebar block or a full-width Layout Builder
  section.
- **Page** — the page number the document opens on (deep-link a manual to page 12).
- **Zoom** — the initial zoom: automatic, actual size, fit page, fit width, or a
  custom percentage.
- **Custom zoom** — the percentage used when Zoom is set to *custom* (useful for a
  scanned document that renders badly at the default zoom).
- **Page mode** — open with the **thumbnails** sidebar or the **bookmarks/outline**
  sidebar already expanded.

### Options for "Display the first page" (thumbnail)

- **Scale** — how large to render the first-page canvas (raise it for a crisp,
  high-DPI cover image).
- **Width** and **Height** — CSS size constraints for the canvas.

### Options for "Continuous scroll"

- **Scale** — the render scale for every page. Keep this format for short PDFs; every
  page is rasterized in the browser, so large documents get slow.

## Global setting — a custom viewer (optional)

By default the module uses the standard pdf.js `viewer.html` you installed under
`/libraries/pdf.js/`. If you've made a re-skinned or localized copy of that viewer,
you can point the module at it:

1. Log in as a user with the **Administer PDF.js** permission.
2. Go to **Configuration → Media → PDF.js** (`/admin/config/media/pdfjs`).
3. In **Custom viewer**, enter the docroot-relative path to your replacement
   `viewer.html`, for example `/themes/custom/mytheme/pdfjs/viewer.html`. Leave it
   empty to use the default viewer.
4. Save.

This setting only affects the **Default viewer** format (the iframe). The two canvas
formats render directly with the pdf.js API and ignore it.

## Theming (optional)

The default viewer's markup comes from a `file-pdf.html.twig` template (a single
`<iframe>`). Copy it into your theme's `templates/` directory to wrap the viewer with,
say, a download button or a caption. The thumbnail and continuous-scroll formats emit
plain `<canvas>`/`<div>` markup with no template — style those with CSS instead.
