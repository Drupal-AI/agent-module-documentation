<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AnimateCSS On Scroll (animatecss_aos) — agent index

Glue module that plugs the **AOS (Animate On Scroll)** library into the **AnimateCSS UI**. It adds an
"AOS" option group to AnimateCSS's *Add animation* form (`animatecss.add`), and on every front-end
page it reads the admin-configured animate selectors out of AnimateCSS's (and optionally AOS JS's)
database tables, converts each one into `data-aos-*` HTML attributes and `drupalSettings`, and calls
`AOS.init()` so the chosen elements animate as they scroll into view. It has **no routes, services,
controllers, permissions, plugin types, drush commands, or config schema of its own** — all behaviour
lives in three procedural hooks in `animatecss_aos.module` plus one CSS + init-JS library.

The module does **not** bundle the AOS library. `AOS.js` ships inside the required **`aosjs`** module
at `web/modules/contrib/aosjs/lib/v3/aos.js` (and `lib/v2/`); animatecss_aos force-attaches the v3
build via the library id `aosjs/aos-v3.js` (swapping out v2 if AOS UI already queued it). Nothing needs
to be placed under `web/libraries/`.

- Depends on: `aosjs:aosjs`, `animatecss:animatecss_ui` (info.yml). Optional/soft integrations checked
  at runtime via `moduleExists`: `aosjs_ui`, `aosjs_animatecss`.
- Core: `^8.8 || ^9 || ^10 || ^11`. Package: `Animate CSS`. Version documented: `1.0.2`.
- **No dedicated settings page / `configure` route.** Configuration is per-selector, done inside the
  AnimateCSS *Add animation* form. No permissions, no config schema, no drush, no plugin types.
- Front-end only. No security surface (see below).

## What you'd do → where

- **Enable + tune AOS on an animation, understand the option fields and the delay/duration mapping,
  and know what markup/settings get emitted** → [configure/aos-options.md](configure/aos-options.md)

## Key facts (real machine names)

- Hooks implemented (all in `animatecss_aos.module`):
  - `hook_page_attachments_alter` → `animatecss_aos_page_attachments_alter()` — builds `$records`
    from `animatecss.animate_manager` (and, if `aosjs_ui`/`aosjs_animatecss` are on,
    `aosjs.animate_manager`), exports `drupalSettings`, attaches libraries.
  - `hook_animatecss_scroll_library_options` → `animatecss_aos_animatecss_scroll_library_options()` —
    registers the `aos` option group (fields `aos_offset`, `easing`, `anchor_placement`, `once`,
    `mirror`); invoked by `animatecss_scroll_options()` in `animatecss.module`.
  - `hook_form_FORM_ID_alter` for form id `animatecss_form` →
    `animatecss_aos_form_animatecss_form_alter()` + submit handler
    `animatecss_aos_form_animatecss_form_submit()` (prepended to the form's `submit`/`overview`
    actions).
  - `hook_install` / `hook_uninstall` (`animatecss_aos.install`) — install shows a status message
    linking to route `animatecss.add`; uninstall strips the `aos` key from stored animate options.
- Library: `animatecss_aos/animatecss_aos` (`css/animatecss_aos.css` + `js/animatecss_aos.init.js`;
  deps `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`).
- External library attached at runtime: `aosjs/aos-v3.js` (provided by the `aosjs` module). Also
  removes `aosjs/aos-v2.js`, `aosjs/aos-v2.cdn`, `aosjs_ui/aos-init` from the attachment list when
  present, and re-adds the corresponding v3 build.
- Services consumed (from other modules): `animatecss.animate_manager`, `aosjs.animate_manager`,
  `module_handler`; config read: `animatecss.settings` (`load`, `compat`), `aosjs.settings`
  (`advanced`, `options.library`).
- JS behavior: `Drupal.behaviors.animateCssAosInit`; helper `Drupal.animateCssAosPrepare(options)`.
  Emits attributes `data-aos`, `data-aos-library`, `data-aos-offset`, `data-aos-delay`,
  `data-aos-duration`, `data-aos-easing`, `data-aos-anchor-placement`, `data-aos-once`,
  `data-aos-mirror`. `drupalSettings` keys: `aosjs.version` (`'v3'`), `aosjs.library`,
  `aosjs.additional`, `animateCssAOS.compat`, `animateCssAOS.elements`.
- Stored `aos` option keys (per animate record): `enable`, `offset`, `delay`, `duration`, `easing`,
  `anchorPlacement`, `once`, `mirror`.
