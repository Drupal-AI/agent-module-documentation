<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
In-browser epub.js reader for generated and uploaded ePubs, plus a response cache for generated ePubs.

---

ePub Generator: Viewer adds an in-browser ePub reader built on epub.js and a response cache for generated ePubs. It provides a **Read online** tab beside **Download ePub** on nodes (on a Book node it opens the entire assembled book), an `/epub/view/{entity_type}/{entity_id}` route for other content entities, and an **ePub viewer (epub.js)** field formatter that renders uploaded `.epub` files inline (non-ePub files fall back to a plain file link). The reader page is a normal render array; epub.js fetches the book client-side via same-origin XHR from the existing `epub_generator` download routes, so those routes' access checks are enforced on every fetch. A kernel event subscriber caches the generated ePub bytes in a dedicated cache bin so reading and repeated downloads do not regenerate the book each request; entries are keyed by route, parameters, query string, content language and (by default) role combination, and invalidated by entity, book-outline, view-display and settings cache tags. Requires the base module and the epub.js and JSZip JavaScript libraries.

---

- Add a **Read online** tab next to the download tab on nodes.
- Open the entire assembled book when reading a Book node online.
- Read arbitrary content entities online via `/epub/view/{entity_type}/{entity_id}`.
- Render uploaded `.epub` files inline with the **ePub viewer (epub.js)** field formatter.
- Fall back to a plain file link for non-ePub files in the same field.
- Give readers a table of contents, page-turning or continuous scrolling, and a progress indicator.
- Offer fullscreen reading and keyboard (arrow-key) navigation.
- Resume each reader at the last position via `localStorage`.
- Show an optional download link in the reader toolbar.
- Cache generated ePub bytes so books are not rebuilt on every read or download.
- Accelerate plain downloads for free through the same response cache.
- Serve `304 Not Modified` on repeat fetches with a matching ETag.
- Key cache entries by role combination to keep role-specific output separated.
- Invalidate cached books automatically when any node in the outline is saved.
- Invalidate on entity edits, view-display changes and settings saves via cache tags.
- Cap the cacheable file size to protect database cache backends.
- Set a maximum cache lifetime, or rely on tag invalidation only (`-1`).
- Flush all cached ePubs from a settings-form button or by clearing the cache bin.
- Configure default reading flow and reader height for the full-page reader.
- Let other modules register their own download routes/tags for caching via alter hooks.
- Warn on the status report when the epub.js/JSZip libraries are missing.
