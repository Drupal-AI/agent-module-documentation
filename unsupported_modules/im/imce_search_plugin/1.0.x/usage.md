<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IMCE Search Plugin adds a search box to the IMCE file browser, with visual previews, jump-to-file navigation and highlighting of matches.

---

IMCE is a directory browser: it shows you the folder you are in. That works while a site has a few dozen files and stops working somewhere around a few hundred, at which point finding an image means remembering which of twenty date-based folders it landed in. Editors respond by re-uploading files they already have, and the library grows faster than anyone can curate it.

This plugin adds the missing verb. It registers as an `ImcePlugin` — the supported extension point — so it appears inside the browser the editor is already using rather than as a separate screen, and results are shown with previews so the right file is identifiable at a glance rather than by filename.

Two practical notes. The project is **`imce_search_2`** but the module it ships is **`imce_search_plugin`**, so `drush en imce_search_2` fails; use the module name. And it requires IMCE `^3.0` and PHP `^8.1`, with the release at **1.0.0-beta2** — a beta, so verify it against your file volume before relying on it in an editorial workflow.

Because it is an IMCE plugin, IMCE's own profile system still governs what a given role can see: search operates within the folders the user's IMCE profile grants, not across the whole filesystem.

---

- Search for a file inside the IMCE browser.
- Find an image without remembering its folder.
- Preview search results visually.
- Jump straight to a file's location.
- Highlight matching files in a listing.
- Stop editors re-uploading files that already exist.
- Work with a media library of thousands of files.
- Locate a file by partial name.
- Keep search inside the browser editors already use.
- Respect IMCE profile folder restrictions.
- Speed up image selection in a WYSIWYG.
- Reduce duplicate uploads in a shared library.
- Audit an unwieldy files directory.
- Verify beta behaviour against a large file set.
- Install it under the right module name.