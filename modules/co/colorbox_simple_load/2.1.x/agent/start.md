<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Colorbox Simple Load — agent index

Makes any link with the **`colorbox-load`** CSS class open its `href` inside a **Colorbox**
lightbox, reading per-link options from the href's **URL query string**. Depends on the
`colorbox` module. No admin UI, no config (`configure: null`), no permissions, no schema,
no plugins, no Drush, no PHP API — you use it entirely from **markup**.

- **The `colorbox-load` class, the URL-param options, width/height mapping, how it hooks Colorbox** →
  [theming/colorbox-load.md](theming/colorbox-load.md)

Key facts:
- Add `class="colorbox-load"` to an `<a>`; its `href` opens in the lightbox.
- Query params on the href become Colorbox options: `width` → `innerWidth`,
  `height` → `innerHeight`; `true`/`yes` and `false`/`no` coerce to booleans.
- Each link = global `settings.colorbox` extended with that link's URL params.
- Global styling/defaults and mobile-detect come from the **Colorbox** module, not this one.
- Runtime: `hook_page_attachments()` attaches `colorbox.attachment` + the
  `colorbox_simple_load/load` library on every page; behaviour is in `js/colorbox-simple-load.js`.
