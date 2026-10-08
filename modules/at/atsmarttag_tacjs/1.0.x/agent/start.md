<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AT Internet SmartTag for TacJS (atsmarttag_tacjs) — agent index

**Bridge module that registers the AT Internet (Piano) SmartTag analytics service as a consent-gated tag in the TacJS (tarteaucitron.js) consent manager.**

- **Version:** 1.0.x (1.0.0)  •  **Core:** ^9.5 || ^10 || ^11  •  **Package:** Statistics  •  **License:** GPL-2.0-or-later
- **Depends on:** `tacjs`, `atsmarttag` (both hard dependencies)
- **No routes, permissions, config objects, config schema, services, entities, or plugins of its own.** It ships two hooks, one JS file, and one library.

## What it actually is

Pure glue, ~45 lines of PHP plus ~40 lines of JS. It makes the existing `atsmarttag` SmartTag load through the TacJS consent layer instead of firing unconditionally.

- `atsmarttag_tacjs.module`
  - `hook_help()` — help text on `help.page.atsmarttag_tacjs`.
  - `hook_page_attachments()` — attaches library `atsmarttag_tacjs/atsmarttag_tacjs` on every page whose route is **not** an admin route (`router.admin_context->isAdminRoute()`).
  - `hook_tacjs_content_alter()` — adds `$content['analytic']['atinternet_smarttag']` (name "AT Internet (SmartTag)", empty `code.js`/`code.html`) so TacJS lists the service. Empty `code` keys are set deliberately to avoid log warnings.
- `atsmarttag_tacjs.libraries.yml` — library `atsmarttag_tacjs` = `js/atsmarttag_tacjs.js`, depending on `atsmarttag/atsmarttag` and `tacjs/tacjs`.
- `js/atsmarttag_tacjs.js` — registers the `atinternet_smarttag` tarteaucitron service; see the mechanism doc.

## Solution docs

- **Hooks, JS mechanism, install/operate, and the consent handoff** → [api/integration.md](api/integration.md)

## Operating it

Enable the module (pulls in `tacjs` + `atsmarttag`), then activate the **AT Internet SmartTag** service in the TacJS module configuration. There is no settings form in this module; SmartTag tracking parameters live in the `atsmarttag` module. No security surface of its own — no endpoints, permissions, secrets, or server-side calls; tag loading is client-side and gated by TacJS consent.
