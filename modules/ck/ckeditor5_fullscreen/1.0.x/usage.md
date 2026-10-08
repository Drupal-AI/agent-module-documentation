<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor5 Fullscreen adds a "Fullscreen" toolbar button to CKEditor 5 that expands the editor to fill the browser viewport, for a distraction-free writing experience.

---

The module registers a single CKEditor 5 plugin (`fullscreen.Fullscreen`) that ships one toolbar button, `Fullscreen`. It adds no field type, no settings form, no configure route, no permissions, no Drush commands, and no config schema of its own. Its entire persistent footprint is the string `Fullscreen` appearing in a text format's CKEditor 5 toolbar items list, which lives on that format's `editor.editor.<format>` config entity (`settings.toolbar.items`). Clicking the button toggles a `data-fullscreen` attribute on the editor's DOM wrapper and on `<body>`; CSS shipped in the module's `fullscreen` library then positions the editor as a fixed, full-viewport overlay and hides Drupal's displaced toolbars/admin bar while it's active. Clicking again (or the button, now showing a "Mode Normal" cancel icon) restores the normal in-page layout. Because it is pure UI/CSS/JS, it has no effect on stored content, filters, or output — it only changes how the editing chrome behaves in the browser.

---

- Add a "Fullscreen" button to the CKEditor 5 toolbar of the Full HTML text format.
- Give content editors a way to write long-form articles without page chrome getting in the way.
- Add fullscreen editing to a Basic HTML format used on a content-heavy site.
- Let editors expand a small CKEditor 5 instance (e.g. in a sidebar or modal) to full-viewport size for easier editing.
- Reduce eye strain / distraction for writers composing long blog posts.
- Add a Maximize toggle so editors can review formatting on a bigger effective canvas.
- Improve the editing experience on a text format used inside a narrow admin form column.
- Pair with CKEditor 5's Source Editing plugin so raw HTML review benefits from the extra screen space.
- Give the fullscreen button per-text-format control — enable it only on the formats where it's useful.
- Support editors working on small laptop screens by letting them temporarily reclaim the whole viewport.
- Configure the toolbar so the fullscreen button sits near other view/layout-related buttons.
- Drag the "Fullscreen" item into a text format's active toolbar via Manage form display / text format configuration.
- Remove the fullscreen button from a text format's toolbar to simplify the UI for casual editors.
- Standardize a fullscreen-enabled toolbar preset across several content types' body fields via their shared text format.
- Improve accessibility of long-document editing by giving low-vision editors more screen real estate.
- Combine fullscreen editing with a wide/aligned image plugin so large embeds are easier to place.
- Avoid scrolling a small iframe/editor region when editing large amounts of markup.
- Let an editor working in a WYSIWYG comment field expand it to full screen for a big edit.
- Use the fullscreen mode's overlay to concentrate on content without the admin toolbar or vertical tabs.
- Export/import the toolbar configuration (including the `Fullscreen` item) as part of a text format's config for deployment.
- Verify via `drush cget editor.editor.<format>` whether a given text format already has the fullscreen button enabled.
- Programmatically add the fullscreen button to an editor's toolbar via `drush php:eval` for automated setup.
- Toggle fullscreen editing off for a specific text format by removing `Fullscreen` from its toolbar items.
- Give theme developers a documented `data-fullscreen` attribute hook to further style the fullscreen overlay.
- Provide editors a "maximize the editor" affordance without writing a custom CKEditor 5 plugin.
