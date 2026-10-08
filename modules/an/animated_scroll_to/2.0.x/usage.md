<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Animated Scroll To makes anchor navigation glide rather than jump: same-page links smooth-scroll to their target on click, and pages loaded with a `#fragment` in the URL animate to that section on load.

---

The module is purely client-side and ships no third-party library — it drives `jQuery.animate()` on `html, body` with the built-in `swing`/`linear` easings. Two independent behaviors, each backed by its own library and toggle: `in_page` wires clicks on `<a href="#anchor">` links, and `on_page_load` handles arriving at a URL that already carries one or more fragments (`/node/1#anchor`, even `page#a#b#c`, scrolled through in sequence) — the case a click handler cannot cover because no click happens. A settings form at `/admin/config/animate-scroll-to/settings` (permission `administer animated scroll to`) sets the site-wide defaults for delay, speed, pause, scroll correction/offset and easing, and turns each behavior on; `hook_preprocess_page()` then attaches the matching library plus the config as `drupalSettings`. Every default can be overridden per target element via `data-scroll-speed`, `data-scroll-pause`, `data-scroll-correction`, `data-scroll-easing` and `data-scroll-delay`, and the on-page-load behavior stamps targets with `data-scroll-state` (`will-become-active` / `is-becoming-active` / `is-active` / `was-active`) as CSS styling hooks. There are no module dependencies and the core range is `^9 || ^10 || ^11`. Nothing runs until a functionality is enabled on the form, since the config is empty on install.

---

- Smooth-scroll to an anchor within the same page on click.
- Animate to a section when arriving with a URL fragment.
- Scroll through several sections in turn from a multi-hash URL (`page#a#b#c`).
- Offset the scroll target for a sticky header via `default_correction` / `data-scroll-correction`.
- Improve navigation on a long documentation page.
- Animate a table-of-contents jump.
- Deep-link to a section and have the page glide there on load.
- Configure scroll speed, delay and easing site-wide from one form.
- Choose `swing` or `linear` easing for the animation feel.
- Tune speed, pause, offset or easing per element with `data-scroll-*` attributes.
- Style the current/visited scroll target with `[data-scroll-state]` CSS hooks.
- Handle fragment links followed from external sites.
- Give in-page links a polished, non-jarring feel.
- Scroll to a deep-linked comment or FAQ answer.
- Restrict who can change scroll defaults via the module's admin permission.
- Enable smooth anchors on a single-page/one-page site.
- Add a pause between successive targets when auto-scrolling a sequence.
- Optionally apply the start delay to in-page clicks too (`in_page_links_use_delay`).
- Skip nonexistent fragment targets gracefully without errors.
- Coexist with Bootstrap toggles (selector excludes `[data-toggle]`).
