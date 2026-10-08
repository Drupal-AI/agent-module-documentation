<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Directories File Link adds an **"Insert file link"** button to CKEditor 5 that opens the Media Directories browser, stores the chosen file media as a `<drupal-media-file-link>` tag, and renders it as a themable download link through a companion text filter.

---

Two plugins make up the module. The CKEditor 5 plugin `media_directories_file_link_button` (class `MediaFileLinkButton`, JS `mediaFileLinkButton.MediaFileLinkButton`) contributes a toolbar item **`mediaFileLinkButton`** labelled *"Insert file link"*, declares the element `<drupal-media-file-link data-entity-uuid data-entity-type data-file-type>`, and is conditioned on the `media_directories_file_link` filter being enabled on the format. Its `getDynamicPluginConfig()` passes `allowedBundles` from `MediaTypeService::getFileBasedBundles()` (so the browser modal only offers media types that actually hold a file) and mirrors the paired filter's `icon` setting so the in-editor widget looks like the rendered output. The filter `media_directories_file_link` ("Media file link", `TYPE_TRANSFORM_REVERSIBLE`, weight 95) converts each `<drupal-media-file-link data-entity-uuid>` into markup produced by a configurable **template** — default `<a href="@file_url">@text</a>` — with the tokens `@file_url`, `@text`, `@name`, `@mime`, `@size`, `@uuid` and `@file_type`. Text tokens are `Html::escape()`d and the URL goes through `UrlHelper::stripDangerousProtocols()`. The result is always wrapped in `<span class="media-file-link">`, and when the `icon` setting is on the wrapper also gets `data-file-type="<category>"` so CSS can render a `::before` icon; `getFileTypeForMimeType()` buckets MIME types into `file`, `text`, `image`, `audio`, `video`, `archive`, `spreadsheet` and `code`. Media that has been deleted, or that the current user may not view, degrades to the plain link text instead of markup. The filter adds cacheability metadata for the media and file entities and attaches the `media_directories_file_link/media_file_link_frontend` stylesheet whenever it rendered at least one link. There is no settings page, no permission and no config object — only per-format filter settings and the CKEditor plugin config.

---

- Give editors a toolbar button that inserts a download link to a document in the media library.
- Pick the file through the Media Directories folder browser instead of pasting a URL.
- Render file links from a site-wide HTML template you control per text format.
- Show the file size next to the link with the `@size` token.
- Show the MIME type or a friendly file-type category with `@mime` / `@file_type`.
- Add a file-type icon automatically via the `data-file-type` attribute and CSS.
- Turn icons off for a minimal text-only link style.
- Keep link text editable in CKEditor while the URL is resolved at render time.
- Survive a file replacement: the link always resolves the media's current file URL.
- Degrade gracefully to plain text when the referenced media has been deleted.
- Respect media view access so restricted files do not leak a URL.
- Serve translated media labels in link text (the filter uses the language-matched translation).
- Restrict the browser modal to file-based media bundles only.
- Style all inserted links consistently through `span.media-file-link`.
- Build a "download card" template with name, size and type in one block.
- Add `target="_blank"` or `download` attributes by editing the template.
- Use it alongside `media_directories_browser`'s in-link-form file picker for two entry points.
- Keep `<drupal-media-file-link>` allowed in `filter_html` so the tag survives.
- Audit which formats offer file links by inspecting `editor.editor.*` toolbar items.
- Migrate hard-coded `/sites/default/files/...` links to media-backed links.
- Let editors insert audio or video files as downloads rather than players.
- Provide correct cache invalidation when a media item or file changes.
- Attach the module's frontend CSS only on pages that actually contain a file link.
- Give press-kit or documentation pages a consistent download-link presentation.
