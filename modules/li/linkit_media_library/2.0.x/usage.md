<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Linkit Media Library adds a **Media Library** button to CKEditor 5's Link dialog, so editors can link text to a media item (typically a document) picked from the media library instead of pasting a URL.

---

The module is a thin bridge between three existing systems: Linkit 7, core's Media Library, and CKEditor 5. It registers one CKEditor 5 plugin, `linkit_media_library_link`, defined in `linkit_media_library.ckeditor5.yml` with the JS plugin `linkitMediaLibrary.LinkitMediaLibrary` and a `conditions.plugins: [linkit_extension]` clause — so the button only appears in text formats where Linkit's CKEditor 5 extension is active. Its PHP class `LinkitMediaLibrary::getDynamicPluginConfig()` looks up the editor's Linkit profile, scans it for an `entity:media` matcher, collects the allowed media bundles (falling back to all media types when the matcher does not restrict them), builds a `MediaLibraryState` whose opener id is `linkit_media_library.opener.editor`, and injects the resulting `media_library.ui` URL into the JS config as `libraryURL`. If the format has no `linkit` filter or the profile has no media matcher, the plugin is silently left unconfigured. The other half is `LinkitMediaLibraryEditorOpener`, a `media_library.opener`-tagged service implementing `MediaLibraryOpenerInterface`: `checkAccess()` requires `use` access on the text format **and** an enabled `linkit` filter on it; `getSelectionResponse()` returns an `EditorDialogSave` AJAX command carrying `data-entity-type=media`, `data-entity-bundle`, `data-entity-uuid`, `data-entity-substitution` (from the matcher's `substitution_type`, defaulting to `media`), `href=/media/<id>` and — always — `target="_blank"`. A `hook_install()` adds an `entity:media` matcher to the `default` Linkit profile when it does not already have one. There is no settings form and no config of its own; setup is entirely Linkit profile + text format configuration.

---

- Let editors link the words "download the brochure" to a PDF held as a Document media entity.
- Insert links to media without leaving CKEditor or copying file URLs by hand.
- Keep links stable when a file is replaced, because the link stores the media UUID.
- Restrict the media picker to a single media type (e.g. Document) by limiting the Linkit matcher's bundles.
- Give a text format its own Linkit profile so different formats offer different media.
- Open linked documents in a new tab automatically (the module always sets `target="_blank"`).
- Use Linkit's substitution plugins so the stored href is rewritten to a canonical or direct-file URL.
- Add media linking to Full HTML while leaving Basic HTML unchanged.
- Convert a legacy workflow of pasting `/sites/default/files/...` paths into managed media links.
- Let editors browse, search and upload in the media library dialog while writing body copy.
- Provide a document-download link in a rich-text field on a Paragraph type.
- Combine with Linkit's node matcher so one dialog links to both content and media.
- Enforce media access rules on inserted links via `checkAccess()` on the opener.
- Keep the `target` attribute allowed by adding it to the format's allowed-HTML tag list.
- Give editors the same media library UI they already know from image embeds.
- Track which nodes link to a media item via the stored `data-entity-uuid`.
- Link to remote-video or audio media entities from body text.
- Migrate to Linkit 7 with media support without writing a custom CKEditor 5 plugin.
- Style media links in the theme by keying off `data-entity-type="media"`.
- Prevent editors from linking to unpublished media by relying on the matcher's settings.
- Offer media linking only to roles that can use a specific text format.
- Set up an editorial "attach a datasheet" flow inside body text on product pages.
- Ensure inserted links survive a media file rename because the href is resolved from the entity.
