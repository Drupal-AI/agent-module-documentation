<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Embedded Microsoft Document Viewer Formatter"

## Install & enable

```bash
composer require drupal/md_viewer
drush en md_viewer -y
```

Dependencies are core **`field`** and **`file`** only. No sub-modules, no permissions of its own,
no Drush commands, no admin settings page.

## Enable it on a field

Plugin id **`mdocviewer_field`**, label **"Embedded Microsoft Document Viewer Formatter"**, defined
in `src/Plugin/Field/FieldFormatter/MDocViewerFieldFormatter.php` with
`field_types = { "file" }`. It applies to **core File fields only** (not image fields, not link
fields, not a custom type).

UI path: add/choose a **File** field on a bundle → *Structure → (bundle) → Manage display* → set
that field's format to **Embedded Microsoft Document Viewer Formatter** → click the gear to set
width/height.

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.page.default \
  content.field_document.type mdocviewer_field -y
drush cr
```

## Settings

From `defaultSettings()`:

| Setting | Default | Meaning |
|---|---|---|
| `width`  | `""`  | iframe width in **px** (a `number` field). Empty → template falls back to `100%`. |
| `height` | `600` | iframe height in **px**. Empty → template falls back to `600px`. |

`settingsForm()` renders both as `#type => number`. `settingsSummary()` shows `Width: @width px`
(or `Width: 100%` when unset) and `Height: @height px`.

Config schema — `config/schema/md_viewer.schema.yml`, type
`field.formatter.settings.mdocviewer_field`, maps `width` and `height` as `integer`. Install
default — `config/install/field.formatter.settings.mdocviewer_field.yml`: `width: ''`,
`height: 600`. `hook_uninstall()` (`md_viewer.install`) deletes
`field.formatter.settings.mdocviewer_field` on uninstall.

## How a file is rendered

`viewElements(FieldItemListInterface $items, $langcode)`:

1. Iterates `getEntitiesToView($items, $langcode)` — core file access/display flags are honored.
2. For each file gets `$file->getFileUri()` and `$file->getFileName()`.
3. **Scheme gate:** `if ($this->streamWrapperManager->getScheme($file_uri) == "public")` — only
   files on the **`public://`** stream are embedded.
   - Public → render element:
     ```php
     $elements[$delta] = [
       "#theme"     => "mdoc_viewer_field",
       "#file_name" => $file_name,
       "#url"       => $this->fileUrlGenerator->generateAbsoluteString($file_uri),
       '#settings'  => ['width' => $this->getSetting("width"),
                        'height' => $this->getSetting("height")],
     ];
     ```
   - Not public (e.g. `private://`) → no element; an error is shown via `messenger()->addError(...)`
     ("Microsoft Docs viewer can display only files that are publicly accessible").

The theme hook `mdoc_viewer_field` (registered in `md_viewer_theme()`) carries `url`, `file_name`,
`settings`, and `embed_link` (defaulting to `Constants::MD_VIEWER_MDOC_EMBEDD_LINK`).

Template `templates/mdoc-viewer-field.html.twig`:

```twig
{% set source = embed_link ~ '?src=' ~ url %}
{% set width  = settings.width ? settings.width ~ 'px':'100%' %}
{% set height = settings.height ? settings.height ~ 'px':'600px' %}
<iframe src="{{ source }}" frameborder="no" style="width:{{ width }};height:{{ height }}"></iframe>
```

So the browser loads
`https://view.officeapps.live.com/op/embed.aspx?src=<absolute-public-file-URL>` in an iframe;
Microsoft's Office Web Apps viewer fetches and renders the document (PDF, .doc/.docx, .xls/.xlsx,
.ppt/.pptx).

## Operating notes (structural, not bugs)

- **Rendering is done by Microsoft, off-site.** The file's absolute URL is handed to
  `view.officeapps.live.com`, whose servers fetch and render it. Two consequences:
  1. The file **must be publicly reachable from the internet** — private files, localhost/DDEV,
     intranet or firewalled hosts will not render. The scheme gate already refuses non-`public://`
     files locally; even a public-scheme file on an unreachable host will fail on Microsoft's end.
  2. **Each embedded document is disclosed to Microsoft.** Acceptable for published/public
     documents; for personal, confidential or internal-audience documents this is a third-party
     data disclosure to decide on deliberately (EU: lawful basis + privacy notice). Don't point
     this formatter at a field that can hold restricted documents.
- Width/height are plain integers in px; leaving width empty yields a responsive `100%`.
