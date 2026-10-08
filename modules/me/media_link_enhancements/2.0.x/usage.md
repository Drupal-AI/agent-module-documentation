<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Link Enhancements rewrites how links to core Media entities behave: it can point them directly at the underlying file, append the file type/size to link text, add a `download` attribute, redirect the `/media/{id}` canonical URL to the source, or return the raw file as a binary response.

---

The module has one global settings form at `/admin/config/media/media_link_enhancements` (permission `administer_media_link_enhancements`) whose config is stored in `media_link_enhancements.settings`. It groups five independent features, each toggled on and scoped to selected media bundles and (optionally) file extensions: **Direct linking** rewrites media anchors on rendered entities and in parsed content to the file path (e.g. `/sites/default/files/x.pdf` instead of `/media/1234`), optionally adding a `download="file.pdf"` attribute; **Type/size appending** appends text like ` [PDF/12KB]` to link text for 508 accessibility, with configurable prefix/separator/suffix/uppercase; **Redirection** turns the media canonical route into a 303 redirect to the source; **Binary response** streams the source file inline at the canonical route; **Content parsing** runs the direct-linking and type/size logic over configured text field types (WYSIWYG bodies) by DOM-parsing their HTML. It works by overriding the `entity.media.canonical` route controller (`MediaLinkEnhancementsController::download`) via a route subscriber, and by implementing `hook_entity_display_build_alter()` to post-process link fields and text fields. Only **published** media in an allowed bundle are affected, and features respect the extension allow-lists. Requires core Media's *Standalone media URL* setting to be enabled. It also ships a Linkit matcher plugin so media picked in Linkit can carry the direct-link flag.

---

- Make a document media link download the actual PDF/DOCX file instead of opening the `/media/1234` page.
- Append the file type and size to a media download link for 508 / WCAG accessibility, e.g. "Annual report [PDF/2MB]".
- Add a `download` attribute so clicking a media link saves the file rather than displaying it inline.
- Limit the download attribute to specific extensions only (e.g. `pdf,doc,zip`).
- Redirect the media canonical page (`/media/1234`) straight to the source file URL with a 303.
- Return an image or PDF directly at the `/media/1234` URL as an inline binary response instead of the media view page.
- Rewrite media links embedded in a WYSIWYG body field to point directly at files (content parsing).
- Scope any of these behaviors to only certain media bundles (e.g. only "Document", not "Image").
- Present appended type/size text in uppercase, e.g. `[PDF/12KB]` instead of `[pdf/12kb]`.
- Customize the wrapper around appended text with a prefix, separator, and suffix (brackets, slash, etc.).
- Keep direct linking working for remote/oEmbed media (video) sources, not just local files.
- Provide a quick "jump to edit" shortcut by appending `?edit-media` to a media alias URL (authenticated users).
- Preserve Linkit-inserted media substitution links while still appending type/size text.
- Only alter links for published media, automatically skipping unpublished items.
- Restrict type/size appending to file-based media bundles (image, file, audio, video).
- Serve private-scheme files through the binary response using the private files base path.
- Improve UX of document libraries by showing users the format and weight before they click.
- Avoid duplicate `/media/x` intermediary pages for direct-download-style sites.
- Apply extension allow-lists so only chosen file types are redirected or returned as binaries.
- Combine appending and direct linking on the same field for a fully described, direct-download link.
