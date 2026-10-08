# Configuration

## Open the settings form

1. Log in as a user with the restricted **Administer entity PDF settings**
   permission.
2. Go to **Configuration → System → Entity PDF**
   (`/admin/config/system/entity_pdf`).

The settings are stored in the `entity_pdf.settings` config object, so they export
and deploy like any other Drupal configuration.

## The settings, field by field

- **Filename** (`filename`, default `[node:nid].pdf`) — the name given to the
  generated file. It accepts **entity tokens**, so you can use patterns like
  `[node:title]-[node:nid].pdf`. Developers can further adjust the result with
  `hook_entity_pdf_filename_alter()`.
- **Temp directory** (`tempDir`, default `sites/default/files/entity_pdf`) — where
  mPDF keeps its temporary and font-cache files. It is **relative to the Drupal
  root** (no leading slash) and must be writable. Point it at a writable directory
  under your Drupal installation.
- **Custom PDF template path** (`customPdfTemplatePath`, default empty) — a directory
  (relative to the Drupal root) containing your own `htmlpdf.html.twig`. Leave it
  empty to use the module's bundled template. It is only honored if a
  `htmlpdf.html.twig` actually exists at that path — and remember to clear the cache
  (`drush cr`) after adding or moving the template. See "The PDF template" below.
- **Open in browser** (`openInBrowser`, default off) — when off, PDFs download; when
  on, they open inline in the browser. Either way you can override per-link by adding
  `?inline=1` to a PDF URL to force inline for that request.
- **Rendering engine** (`renderingEngine`, default *MPdf 8*) — which PDF back-end to
  use. The default mPDF engine is bundled; other modules can add engines that appear
  in this list.
- **Rendering engine options** (`renderingEngineOptions`) — a set of per-engine
  settings shown as vertical tabs. Each engine supplies its own sub-form; the values
  are stored per engine.

You can also set any of these from the command line, for example:

```bash
drush config:set entity_pdf.settings filename '[node:title].pdf' -y
drush config:set entity_pdf.settings openInBrowser 1 -y
```

## The PDF template

The markup of the PDF comes entirely from a Twig template,
`templates/htmlpdf.html.twig`, which receives `title`, `content`, `base_url`, and
`langcode`. Crucially, **none of your site's CSS or JS is attached** — the template
*is* the whole document, so put all styling inline. This is what keeps the output
clean and branded rather than a copy of your themed pages.

To customize it, copy the bundled template into the directory you set as **Custom PDF
template path** and edit it there, then run `drush cr`. The module also adds
`field__<view_mode>` template suggestions, so you can theme individual fields
specifically for their print/PDF view mode.

A useful pattern: create a dedicated **"pdf" view mode**, arrange and theme the
fields for print in *Manage display*, and generate PDFs against that view mode.

## Permissions

Entity PDF declares these permissions:

| Permission | Restricted? | What it allows |
|------------|-------------|----------------|
| **Administer entity PDF settings** | Yes | Access to this settings form. |
| **View PDF for all entities** (`view entity pdf`) | No | Generate the PDF for **any** entity. |
| **View `<type>.<bundle>.<view_mode>` pdf** | No (generated per view display) | Generate the PDF for one specific view display. |

## Bulk export and Display Suite

- **Bulk PDF (Views/VBO):** the module ships a configurable **Entity Pdf Download**
  action. Add it to a view of nodes to let editors select several rows and download a
  single combined, multi-page PDF.
- **Display Suite field:** a PDF field is available for node view modes so you can
  place a "Download PDF" link directly in the entity's display.

## Adding a custom rendering engine

Developers can add a different HTML-to-PDF back-end by writing an
`EntityPdfRenderingEngine` plugin, then selecting it here (or setting
`entity_pdf.settings:renderingEngine`). The plugin interface and a skeleton are in
the [`agent/`](../../agent/start.md) docs.
