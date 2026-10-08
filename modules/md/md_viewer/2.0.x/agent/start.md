<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microsoft Document Viewer (md_viewer) — agent index

A single **file-field formatter** that displays an attached Office/PDF document inline by embedding
Microsoft's hosted Office viewer (`view.officeapps.live.com`) in an `<iframe>`. Package
*Field Formatter*. Version **2.0.1**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Despite the machine name, this is **not** a Markdown viewer.

- **The formatter, its two settings, install/enable, per-display config, and the exact iframe it
  builds** → [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `MDocViewerFieldFormatter` (id **`mdocviewer_field`**, label *"Embedded Microsoft
  Document Viewer Formatter"*), in
  `src/Plugin/Field/FieldFormatter/MDocViewerFieldFormatter.php`, extending core's
  `FileFormatterBase`. `field_types = { "file" }` — **core file fields only**.
- Dependencies: core **`field`** and **`file`**. No routes, no controllers, no permissions of its
  own, no services, no Drush.
- Hooks in `md_viewer.module`: `hook_help` (help.page.md_viewer), `hook_theme` (registers theme
  `mdoc_viewer_field`). `hook_uninstall` in `md_viewer.install` deletes the leftover config object
  `field.formatter.settings.mdocviewer_field`.
- `src/Constants/Constants.php`: `Constants::MD_VIEWER_MDOC_EMBEDD_LINK =
  "https://view.officeapps.live.com/op/embed.aspx"`.

## Mechanism (from source)

- `viewElements()` iterates `getEntitiesToView()` (so core file access is honored). For each file
  it checks `streamWrapperManager->getScheme($file_uri) == "public"`. If public it builds a
  `#theme => 'mdoc_viewer_field'` element with `#url =
  fileUrlGenerator->generateAbsoluteString($file_uri)`, `#file_name`, and `#settings` (width,
  height). If **not** public it renders nothing and shows an error message ("can display only
  files that are publicly accessible").
- Template `templates/mdoc-viewer-field.html.twig` outputs
  `<iframe src="{embed_link}?src={url}" ...>` — width/height default to `100%`/`600px`.
- Config schema `config/schema/md_viewer.schema.yml` defines the formatter settings (width,
  height, integers). Install default `config/install/field.formatter.settings.mdocviewer_field.yml`
  = `width: ''`, `height: 600`.

## Two structural consequences to state every time — both are how it works, not bugs

1. **The file must be publicly reachable from the internet.** Microsoft's servers fetch it, so a
   private-filesystem file, an intranet host, or anything behind HTTP auth will not render.
2. **Every document shown this way is disclosed to Microsoft**, whose infrastructure retrieves and
   processes it. Fine for a published brochure; for personal/confidential/internal documents it is
   a third-party disclosure needing a decision (and, in the EU, a lawful basis + privacy notice).
   Do not attach this formatter to a field that can hold restricted documents.
