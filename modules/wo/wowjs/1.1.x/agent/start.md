<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WOW JS (wowjs) — agent index

Integrates the **WOW.js** JavaScript library so **Animate.css** animations fire as elements scroll
into the viewport. The base **`wowjs`** module is code-only: `wowjs_page_attachments()`
(`wowjs.module`) attaches the WOW.js asset plus an init behavior on every page, and the init file
`js/wowjs.init.js` (`Drupal.behaviors.wowInit`) finds every `.animate__animated` element (or
`.animated` in Animate.css v3 "compat" mode), tags it `.wow`, and runs `new WOW().init()`. There is
no admin form in the base module — animations are driven purely by markup classes. The optional
**`wowjs_ui`** submodule (present in this package, not enabled by default) adds a real configuration
UI and per-element control by hooking into the **AnimateCSS UI** admin screens.

The WOW.js library itself is **not bundled**. `wowjs_check_installed()` (`wowjs.module:50`) asks
`library.discovery` for the `wow-local` library and checks `file_exists()` on
`/libraries/wow/dist/wow.min.js`. If that file is present the local library is attached; otherwise
the module falls back to a **jsDelivr CDN** copy (`//cdn.jsdelivr.net/npm/wowjs/dist/wow.min.js`).
`hook_requirements` (`wowjs.install`) surfaces this on the status report (OK when local, WARNING when
using CDN unless `wowjs.settings:hide` is set).

- Depends on: `animatecss:animatecss` (supplies the Animate.css library and, via its UI submodule,
  the shared settings page). Base module has no other dependency.
- Core: `^8.8 || ^9 || ^10 || ^11`. Package: `Animate CSS`. Composer: `drupal/wowjs`.
- No settings page, permissions, services, plugin types, or drush commands in the **base** module.
  (The README mentions a `drush wowjs` command — no such command exists in the source.)
- Submodule `wowjs_ui` adds: a settings form injected into the `animatecss.settings` route, config
  object `wowjs.settings` (+ schema), two services, and several AnimateCSS form/hook integrations.

## What you'd do → where

- **Configure WOW load method (local/CDN), minified/source, and the default animation options; or
  enable/tune WOW per animation** (needs `wowjs_ui`) → [configure/settings.md](configure/settings.md)
- **Just animate markup with the base module** → add class `wow` plus an Animate.css class (with the
  `animate__` prefix), e.g. `<section class="wow animate__slideInLeft">`. No configuration needed;
  the base module auto-inits WOW.

## Key facts (real machine names)

- Base libraries (`wowjs.libraries.yml`): `wowjs/wow-local` (local `/libraries/wow/dist/wow.min.js`),
  `wowjs/wow-cdn` (jsDelivr), `wowjs/wow-init` (`js/wowjs.init.js`). Init behavior: `wowInit`.
- Base hooks (`wowjs.module`): `hook_help` (`help.page.wowjs`), `hook_page_attachments`. Helper
  `wowjs_check_installed()`. Install: `hook_requirements`, `hook_install`; constant
  `WOWJS_DOWNLOAD_URL`.
- `drupalSettings.wowjs.compat` — boolean passed to JS; TRUE only if `animate_ui` is enabled and its
  `animatecss.settings:compat` is set (Animate.css v3 vs v4 class prefix).
- Base `hook_page_attachments` **early-returns when `wowjs_ui` is enabled** — the submodule then owns
  attachment.
- Submodule config object: `wowjs.settings` (install default `wowjs_ui/config/install/wowjs.settings.yml`,
  schema `wowjs_ui/config/schema/wowjs.schema.yml`). Keys: `hide`, `method` (`local`|`cdn`),
  `minimized.options` (`0`=source, `1`=minified), and `options.{boxClass, animateClass, offset,
  mobile, live, once, mirror, optionalContainer, scrollContainer, resetAnimation}`.
- Submodule services (`wowjs_ui.services.yml`): `wowjs.route_subscriber`
  (`Drupal\wowjs_ui\Routing\RouteSubscriber` — sets `_form` of route `animatecss.settings` to
  `Drupal\wowjs_ui\Form\WowJsSettings`); `wowjs.wow_manager` (declared class
  `Drupal\wowjs_ui\WowJsManager` — **class file is absent from the package**; the lazy service is
  never requested, so it does not break the site).
- Submodule form: `Drupal\wowjs_ui\Form\WowJsSettings` (extends `animatecss_ui`'s
  `AnimateCssSettings`), rendered at the AnimateCSS settings route. `configure` link in
  `wowjs_ui.info.yml` → `animatecss.admin`.
- Submodule hooks (`wowjs_ui.module`): `hook_help` (`help.page.wowjs_ui`), `hook_page_attachments`,
  `hook_animatecss_scroll_library_options` (adds `wow` library `once`/`mirror` fields to the
  AnimateCSS add-animation form), `hook_form_animatecss_form_alter` + submit
  (`wowjs_ui_form_animatecss_form_submit`, stores `wow.enable`/`once`/`mirror` into each animate
  record's serialized `options`). Reads stored records via the `animatecss.animate_manager` service.
- Submodule libraries (`wowjs_ui.libraries.yml`): `wowjs_ui/wow.js`, `wow.dev`, `wow.cdn`,
  `wow.cdn.dev`, `wow-init` (`Drupal.behaviors.wowJS`, `Drupal.WOW`, `Drupal.wowScrollEventListener`).
- Submodule updates (`wowjs_ui.install`): `wowjs_ui_update_8001`–`8004` (adds `hide`, `once`,
  `mirror`, `resetAnimation`, `boxClass`). `hook_uninstall` deletes the `wowjs.settings` config row
  and strips `wow` keys from stored animate records.
