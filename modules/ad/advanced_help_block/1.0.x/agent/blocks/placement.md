<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Getting Advanced Help Block notices to appear

**Key fact:** this module ships **no block plugin**. Its output rides on **Drupal core's built-in
"Help" block**, because the module implements `hook_help()`. If the core Help block is not placed in
a visible region, nothing this module produces is shown (unless you switch output to "Message").

## Steps

1. **Enable the module** and its dependencies (`field_group`, `libraries`, `datalayer`, core
   `text`, `options`, `user`, `help`). For the YouTube modal, put the `grt-youtube-popup` asset in
   `/libraries/grt-youtube-popup/` (the `libraries` module resolves it).
2. **Author a help entity** at `/admin/advanced_help_block/add`:
   - **Title** — short heading (`field_ahb_title`).
   - **Description** — the rich-text body (`field_ahb_description`, filtered by the text format you
     pick).
   - **Video** — optional YouTube watch URL; becomes a "Watch video" button opening a modal.
   - **Pages** — comma-separated path patterns, e.g. `/node/add/*, /admin/content`. `*` is a
     wildcard; `<front>` is the front page. **Empty = shown nowhere.**
   - **Visibility rules** — `Show for the listed pages` (`include`) or `Hide for the listed pages`
     (`exclude`).
3. **Choose the output mode** at `admin/structure/advanced_help_block`:
   - **Block** (default) — notices render inside the core Help block, each with Show more/less and a
     dismiss (×) button; dismissals persist in the `AHB_hidden` cookie.
   - **Message** — notices are pushed as status messages (`\Drupal::messenger()`) instead.
4. **Place core's "Help" block** (Structure → Block layout → *Place block* → **Help**) in the region
   where you want the notices, and restrict that block's own visibility to the same admin routes if
   appropriate. The Help block is what invokes `hook_help()` and prints the matched entities.

## Matching model

On each request the module loads every help entity and keeps those where the current path (alias
lowercased, trailing slash trimmed) matches `field_ahb_pages` under the chosen include/exclude rule
(`path.matcher` service). There is no per-entity render cache — `hook_help()` forces
`max-age = 0`, so the block re-evaluates every request.

## Gotchas

- Notices never appear if the **core Help block is not placed** (Block output mode).
- `Pages` **empty → nowhere**; `*` → **everywhere**, public pages included. Scope deliberately.
- The include/exclude logic is evaluated per listed path and short-circuits on the first match, so
  mixed intentions in one Pages field can behave unexpectedly — keep each entity's rule simple.
- The description honours whatever **text format** the author selects; a permissive format (e.g.
  Full HTML) means richer markup is allowed — grant such formats only to trusted authors.
