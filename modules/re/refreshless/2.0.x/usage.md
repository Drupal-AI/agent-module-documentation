<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RefreshLess makes Drupal navigation feel like a single-page app by intercepting link clicks and swapping page content over JavaScript, while keeping a full server-rendered fallback when JS is unavailable.

---

It relies on progressive enhancement: the browser still receives normal Drupal HTML, and RefreshLess (built on Hux hook attributes) layers partial page loads, asset diffing and BigPipe cooperation on top. A `RefreshlessKillSwitch` service plus an HTTP middleware and a kill-switch cookie let the site opt individual responses out of RefreshLess handling; two cache contexts (`refreshless_enabled`, `refreshless_request`) let render arrays vary between a RefreshLess partial load and a full page load. A `PageState` value object and `RequestWrapper` factory track the drupalSettings/asset state carried between navigations.

The module exposes no routes, permissions or configuration UI and does not call external services — it is a pure front-end/runtime enhancement. Operationally the main task is enabling the module (and its `hux` dependency) and confirming BigPipe is available; install requirements warn if BigPipe support is missing. Security posture is low: no user input reaches a sink, no anonymous endpoints, all behavior is client-side navigation plus cache-context/middleware plumbing.

---
- Install RefreshLess to add fast in-place navigation to an existing Drupal theme.
- Give visitors an SPA-like feel without building a decoupled front end.
- Keep the site fully functional when JavaScript fails to load.
- Reuse existing Twig templates, libraries and caching unchanged.
- Speed up navigation by avoiding full CSS/JS re-initialization per page.
- Cooperate with BigPipe for progressive content streaming.
- Vary rendered output between partial and full loads via cache contexts.
- Opt a specific response out of RefreshLess using the kill switch service.
- Set a kill-switch cookie to disable RefreshLess for a session.
- Carry drupalSettings state across navigations with PageState.
- Diff and additively load asset libraries between pages.
- Audit whether BigPipe is enabled through install requirements.
- Extend behavior via Hux hook attribute classes.
- Provide resilient navigation under poor network conditions.
- Avoid re-implementing a front-end framework for perceived speed.
- Debug navigation by toggling the kill switch.
- Combine with standard Drupal caching for cache-friendly partial loads.
- Roll out progressive enhancement incrementally per site.
