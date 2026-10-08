<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pager provides a configurable block that shows previous/next links between individual nodes — a thumbnail, title and prev/next label — not the numbered paging of a listing.

---

Two unrelated things share the word "pager"; do not confuse them. Core/Views' pager moves through **pages of a list**; this module moves through **individual nodes in a chronological sequence** — the previous and next article, the next item in a tagged collection. It ships **one plugin, a Block** (`id: pager`, "Pager Block"), and nothing else in the installed **3.0.1** release (the Views-integration sub-modules exist only on the 3.1.0-beta line and are not here). The mechanism is concrete and narrow: place the block on node pages, and on any node route it runs raw SQL against `node_field_data` joined to `taxonomy_index` to find the neighbouring **published** nodes ordered **strictly by the node `created` timestamp** — there is no weight field, menu order or custom sort, despite what a first glance at the wide dependency list (`block`, `filter`, `node`, `system`, `taxonomy`, `text`, `user`) might suggest. Each block instance is configured entirely on the **block placement form** (there is no standalone settings page — the `configure: pager.admin` link in the .info.yml points at a route the module never defines): Previous/Next text, an **Image Field** and **Image Style** (both required — a node with no value in that image field still links but shows no picture), a **Theme** (`pager_block` centred, or `pager_wings` fixed slide-out side tabs), the **Content Types** and **Taxonomy Terms** to include (both required), **Maintain Term** (keep the current node's term vs. any selected term), **Direction** (forward = oldest→newest, or backward), and **End Behavior** (`loop` back to the first/last, `single` show only one link, or `current` link to self). Because the neighbour set changes as content is added, unpublished or retagged, the build sets `#cache max-age 0` (the block is uncacheable and recomputed every request). Two conditions gate visibility: the current node's type must be in the selected types, and it must be tagged with one of the selected terms — otherwise `getTid()` returns 0 and the block renders empty. The `administer pager` permission is declared but unused; block placement is governed by core's `administer blocks`.

---

- Add previous/next node links to articles tagged with a shared taxonomy.
- Navigate chronologically between items in a tagged collection.
- Move readers through a serialised archive of posts, oldest to newest.
- Show a thumbnail-plus-title prev/next widget under node content.
- Link between news items that share a category term.
- Add a slide-out side-tab "wings" pager fixed to the viewport edges.
- Add a centred prev/next block below an article body.
- Keep prev/next navigation within a single content type.
- Navigate across several content types that share a taxonomy and image field.
- Loop from the newest item back to the oldest (End Behavior: loop).
- Stop at the ends, showing only one link (End Behavior: single).
- Link the first/last item to itself at the boundary (End Behavior: current).
- Reverse the reading order with Direction: backward.
- Keep the neighbour within the current node's exact term (Maintain Term).
- Present a photo/portfolio series with image thumbnails between items.
- Customise the "Previous"/"Next" labels per block placement.
- Reduce returns to an index page between items.
- Restrict a pager to a curated set of taxonomy terms.
- Give a blog category its own next-article navigation.
- Show sequence navigation only on node pages that qualify (else render nothing).
