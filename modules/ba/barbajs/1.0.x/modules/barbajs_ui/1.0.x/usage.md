Barba JS UI adds an admin settings form that controls how, where and which Barba.js builds the Barba JS module attaches.

---

Barba JS UI is the configuration front-end for Barba JS. Enabling it disables the base module's blanket auto-attach and instead attaches libraries according to the `barbajs_ui.settings` config object, edited at Configuration → User interface → Barba (`/admin/config/user-interface/barba/settings`, permission `administer barba`). From one form you set a global load on/off switch, choose Local or CDN delivery, pick the minified (deployment) or non-minified (development) build, enable the core library and any of the CSS, Prefetch and Router plugins, and scope loading to particular themes or path patterns. A visitor can also suppress Barba for a single request with `?barba=no`. If you save with every file unchecked, the module resets to defaults (core on, plugins off) and turns global loading off so the page never ends up with nothing to load.

---

- Turn Barba.js loading on or off site-wide from an admin form instead of code.
- Choose whether the library is served Local (bundled/`/libraries` build) or from the jsDelivr CDN.
- Switch between the minified production build and the non-minified development build.
- Enable only Barba core, or add the CSS, Prefetch and/or Router plugins per site.
- Prevent double-loading Barba by disabling load when a theme already ships it.
- Restrict Barba to only your public-facing theme(s) via "only the selected themes".
- Load Barba everywhere except a chosen admin theme via "all themes except those selected".
- Limit Barba to specific pages using path patterns like `/blog/*` (only-listed mode).
- Exclude Barba from admin, node add/edit, IMCE, print, AJAX and batch paths (shipped default list).
- Let visitors disable Barba per request by adding `?barba=no` to any URL (debugging / QA).
- Keep Barba off `/admin*` while leaving it active on all content pages.
- Configure everything through a vertical-tabs UI (Files / Themes / Pages) with live state toggles.
- Guard against an empty selection: saving with no files reverts to core-on and load-off automatically.
- Match front-page targeting with the `<front>` token in the page list.
- Apply the same minified/non-minified choice to both Local and CDN delivery at once.
- Grant a dedicated site-builder role the `administer barba` permission to manage transitions.
- Pin the tested Barba versions surfaced in the UI (core 2.10.3, css 2.1.16, prefetch 2.2.0, router 2.1.11).
