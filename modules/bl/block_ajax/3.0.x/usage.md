<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ajax Block adds a "Load block via Ajax" switch to any block's configuration form, so a chosen block renders a placeholder in its region and fetches its real markup over Ajax after the page has loaded.

---

On a cached site, a single block that varies per user or per request — a basket total, a greeting, a live count — can drag the whole page out of the page cache. Ajax Block lets you flag such a block on its normal block-layout form: it then renders a lightweight placeholder and the module's client library (`block_ajax/ajax_blocks`) requests the block's markup from a custom route (`/block/ajax/{block_id}`, plus node, taxonomy-term and user context variants) and swaps it into place. Per block you can set a max-age, a loading spinner with placeholder text, a click-to-load button, or a timed refresh interval, and pick a page-context type (node/term/user) whose id is passed to a context route so the block can resolve tokens against the current page. Responses come back as JSON with `no_cache: TRUE`, and the module manages a `block_ajax` cache tag so placeholders are not served stale. Configuration is entirely per block; there is no separate settings page, and the `configure` link goes to the standard Block layout page (which the module relabels Ajax-enabled blocks on). The maintainers note that in many cases core BigPipe or lazy builders already solve the same problem.

---

- Load a personalised block after page render.
- Keep a page cacheable despite one dynamic block.
- Refresh a block on a timed interval without reloading the page.
- Show a basket/cart total on a cached page.
- Load an expensive block lazily after first paint.
- Update a live counter or feed periodically.
- Render a block against the current node's token context.
- Defer below-the-fold block rendering.
- Add a click-to-load button in front of a heavy block.
- Show a spinner with custom placeholder text while a block loads.
- Show a per-user greeting on an anonymous-cached page.
- Reduce cache fragmentation from one varying block.
- Refresh a block after a user action via the RefreshAjaxBlock event.
- Trigger a block refresh from a server-side Ajax command.
- Load a block in a taxonomy-term context.
- Load a block in a user context.
- Improve time to first byte on cached pages.
- Serve a dynamic block from an otherwise static page.
- Reduce origin load behind a CDN.
- Relabel Ajax-enabled blocks on the Block layout page.
- Set a per-block max-age for the fetched markup.
- Choose POST or GET and a timeout for the Ajax request.
