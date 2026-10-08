<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AJAX BigPipe lets you mark individual blocks so they load in the background via AJAX once they scroll into view, keeping the initial page HTML small and the shell fast.

---

Install it like any module (`drush en ajax_big_pipe`); it depends on core's **BigPipe** and **REST** modules and pulls in no external libraries. There is **no settings page** — you turn it on one block at a time. Edit a block, open its **Visibility** tab, and tick **"Use AJAX BigPipe"**. From then on the module replaces that block with a lightweight placeholder in the page HTML; when the placeholder scrolls near the viewport, an `IntersectionObserver` in `misc/ajax_big_pipe.js` fetches the real block from the module's `/api/bigpipe` endpoint and swaps it in. Per block you can choose what shows while it loads: an animated **spinner**, one of several CSS **skeleton templates** (`views`, `block`, `banner`), your own **custom markup**, or a **static preview** (a one-time sanitized snapshot of the block cached and shown until the live content arrives). A **"distance"** setting controls how far before the viewport loading begins, so content is usually ready by the time the user reaches it. Requests to the endpoint are validated with a `hash_salt`-keyed token that pins each call to the exact render callback and arguments the server emitted, and a `big_pipe_nojs` cookie cleanly disables the whole mechanism for no-JS clients. The module also registers an **"AJAX BigPipe" Status toggle on Views displays**, though in 1.0.8 that flag is stored but not yet consumed — the block path is the one that works end to end. Because the fragments arrive after page load, this is a rendering/perceived-performance tool: make sure anything downstream that parses AJAX responses, and any block whose content varies per visitor, is tested with it enabled.

---

- Lazy-load a heavy block only when it scrolls into view.
- Shrink the initial HTML payload of a page.
- Speed up perceived load time on long pages.
- Defer a below-the-fold block until the user scrolls to it.
- Show a spinner while a slow block loads.
- Show a CSS skeleton (views / block / banner) placeholder while loading.
- Provide custom loading markup for a specific block.
- Display a static snapshot of a block as its loading preview.
- Start loading a block a set distance before it reaches the viewport.
- Reduce time-to-first-content on content-heavy landing pages.
- Offload an expensive sidebar block off the critical render path.
- Progressively render a dashboard made of many blocks.
- Load a marketing/banner block after the main content paints.
- Keep the page shell fast while a personalized block streams in behind it.
- Improve responsiveness of an AJAX/scroll-heavy interface.
- Fetch block content through the `/api/bigpipe` REST endpoint on demand.
- React to fragments arriving via the `ajaxBigPipeLoad` DOM event.
- Fall back to normal inline rendering for no-JS clients via the `big_pipe_nojs` cookie.
- Turn the behavior on or off per individual block, with no global config.
- Extend core BigPipe-style placeholdering to scroll-triggered AJAX loading.
