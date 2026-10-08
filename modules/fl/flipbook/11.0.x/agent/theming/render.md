# Flipbook — rendering, libraries & Views

## Asset libraries (`flipbook.libraries.yml`)

Two libraries with the same JS stack, differing only in CSS:

| Library | CSS | Used when |
|---|---|---|
| `flipbook/flipbook` | `bootstrap.min.css`, `bootstrap-theme.min.css`, `style.css` | popup mode (`pdf.choice == 1`) |
| `flipbook/flipbook_nopopup` | `bootstrap.min.css`, `bootstrap-theme.min.css`, `style1.css` | inline mode (default) |

Shared JS (bundled in the module, no CDN): `bootstrap.min.js`, `html2canvas.min.js`, `three.min.js`,
`pdf.min.js`, `3dflipbook.min.js`, `custom.js`. Dependencies: `core/jquery`, `core/drupalSettings`.
`js/custom.js` reads `drupalSettings` and instantiates the 3D flipbook.

## Theme hooks & templates (`flipbook_theme`)

| Theme hook | Template | Where |
|---|---|---|
| `field__flipbook__flipbook__flipbook` | `templates/flipbook.html.twig` | the PDF field on the entity view |
| `views_view_field__field_flipbook` | `templates/flipbook.html.twig` | a "Flipbook PDF" field in a View |

Both use `flipbook_preprocess_flipbook()` as a preprocess function.

## `flipbook_preprocess_flipbook()` — what it passes to JS

For the `#object` (flipbook entity) it:
- Loads the PDF file (`flipbook` field target) and builds an **absolute** URL via
  `@file_url_generator->generateAbsoluteString()`.
- Loads the cover file (`flipbook_cover`) → absolute URL.
- Reads `config.flipbook_chooseconfig` → `pdf.choice`; attaches `flipbook/flipbook` if `1`,
  else `flipbook/flipbook_nopopup`.
- Sets Twig vars `title`, `bannercover`, `url`, `pdfchoice`, and `drupalSettings`:
  `modulepath` (flipbook module path), `pdfpath` (PDF URL), `pdfchoice`, `host`
  (`request->getSchemeAndHttpHost()`).

## Views integration

The entity provides `EntityViewsData`, so you can build a View of flipbooks. Per the README: add the
**"Flipbook PDF"** field, edit it, and under *Style settings* enable **"Use field template"** so the
`views_view_field__field_flipbook` hook picks up `flipbook.html.twig` and renders the book (rather
than a raw file link). `templates/views-view-field--flipbook.html.twig` is the Views field template
shipped for this.

## Notes for customizing

- PDFs load client-side via `pdf.min.js`; the absolute file URL is exposed in `drupalSettings.pdfpath`
  and rendered in the browser — this is public (unless you place the files behind private-file
  access), so treat flipbook PDFs as publicly reachable assets.
- To restyle, override `flipbook.html.twig` in your theme or add CSS after the module's library.
- The popup vs inline choice is global (`pdf.choice`); there is no per-entity display toggle.
