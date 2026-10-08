<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up the Google Docs media source

1. Create a **Media type** and choose **GoogleDocs** as the media source.
2. Add/select a source field of type `link`, `string`, or `string_long`.
3. Editors paste either a **published** Google Docs embed URL or a full `<iframe>` embed code.

## Accepted values
The `GoogleDocsEmbedCode` constraint enforces one of two regexes (case-insensitive):
- A bare URL: `//docs.google.com/.../{spreadsheets|presentation|document|forms}/d/[e/]<id>/(pubhtml|pub?embedded=true|embed|viewform?embedded=true)...`
- The same wrapped in `<iframe src="...">...</iframe>`.

Captured metadata: `shortcode` (the src URL), `type` (document/spreadsheets/presentation/forms), `id`.

## Rendering
Use the **GoogleDocs embed generic** (`googledocs_embed_generic`) field formatter on the source field. Settings: `width` (default 480), `height` (default 299), `scrolling`, `fullscreen`. It emits `<iframe src="{shortcode}" ...>`.

## Security notes
- No server-side HTTP request is made — the browser loads the iframe, so there is **no SSRF** and no `verify => false` / TLS surface in this module.
- The embed `src` is confined to `docs.google.com` published-embed URLs by the validation regex.
- Thumbnails: type-specific icons are served from the media `icon_base_uri` (e.g. `googledocs_document.png`).
