<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Aggregation JS CSS async defer adds `async` or `defer` attributes to Drupal asset libraries — per library, or forced across all JS/CSS — and produces aggregate files split so each carries a single attribute.

---

A synchronous `<script>` blocks HTML parsing while it downloads and executes, one of the largest self-inflicted delays on a typical page. `defer` downloads in parallel and executes after parsing in document order; `async` downloads in parallel and executes whenever it arrives, out of order. Drupal already supports these per library in `libraries.yml`, but only for libraries you author — and most of a site's script weight is core and contrib, whose declarations are not yours to edit. This module makes the attribute a site-level setting: it replaces core's `asset.resolver` and the CSS/JS `collection_grouper` services (via a `ServiceProvider`, no hooks) so that, driven by `agg_jscss_asyncdefer.settings`, it injects `async`/`defer` into any library's assets and rewrites aggregation grouping so a deferred bundle and an async bundle are emitted as separate combined files rather than one mixed file. Configure it at Configuration ▸ Development ▸ Performance (`/admin/config/development/performance/agg-jscss-asyncdefer`, gated by `administer site configuration`): two "Force all JS / CSS" radios (None/Async/Defer) plus per-library None/Async/Defer radios for every core, module, default-theme and base-theme library. Version **1.0.1** on core `^10 || ^11`. Two things make this a change to test rather than apply. **Order and timing are what break**: `async` reorders execution, so a script depending on another not yet run fails intermittently — the worst failure mode, because it hinges on network timing and will not reproduce on a fast connection; `defer` preserves order and is the safe default, with `async` reserved for genuinely independent scripts such as analytics. And **Drupal's own JavaScript has dependencies** — `drupalSettings`, `once`, behaviours attaching on `DOMContentLoaded` — so an attribute forced broadly across core and contrib is exactly where intermittent breakage originates. Measure the gain, apply narrowly per library, and test on a throttled connection.

---

- Defer render-blocking scripts site-wide.
- Add `async` to a third-party analytics script.
- Apply `defer` to a single contrib module's library.
- Force `defer` on all JavaScript from one settings screen.
- Split aggregates into a deferred bundle and an async bundle.
- Improve Largest Contentful Paint (LCP).
- Reduce parser-blocking JavaScript time.
- Raise a Lighthouse / PageSpeed performance score.
- Address a "eliminate render-blocking resources" audit warning.
- Improve Time to Interactive (TTI).
- Improve first paint on a marketing landing page.
- Defer a heavy widget's script that a page does not need immediately.
- Load a non-critical CSS library without blocking render.
- Tune asset loading without editing core or contrib `libraries.yml`.
- Apply attributes to libraries you do not own.
- Improve mobile performance on slow connections.
- Address Core Web Vitals warnings.
- Selectively defer only the libraries that are safe, leaving core JS synchronous.
- Support a front-end performance audit with per-library control.
- Reduce blocking time measured on a throttled network profile.
- Keep aggregation on while still controlling script timing.
- Experiment with async/defer per library before hard-coding it in a theme.
