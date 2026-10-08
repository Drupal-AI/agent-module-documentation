<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Critical CSS UI stores above-the-fold "critical" CSS as database entities and inlines the fragment matching the current page context into the `<head>`, deferring the rest of the stylesheets to load asynchronously.

---

Critical CSS UI adds an admin UI and a `critical_css` content entity type for managing critical (above-the-fold) CSS from the database instead of from theme files. Each entity pairs a `target_context` string (for example `node:123`, `node:article`, or `default`) with a block of CSS and an enabled/disabled status. It decorates core's `asset.css.collection_renderer` service: when enabled (config `critical_css_ui.settings:enabled`) and the current route is not an admin route or AJAX request, the `CriticalCssProvider` resolves the current node from route parameters, builds candidate contexts in order of specificity (`node:{id}` → `node:{bundle}` → `default`), loads the first matching enabled entity, and the `CssCollectionRenderer` decorator inlines its CSS in a `<style id="critical-css">` tag while rewriting the remaining stylesheet links to load asynchronously (print-media + onload swap, with a `<noscript>` fallback). Everything is gated behind the `administer critical_css` permission. The module ships a settings form under Configuration → Development → Performance → Critical CSS, an entity list builder, add/edit/delete forms, and contextual "Critical CSS" tabs on node pages and content-type edit pages (via a local-task deriver) that auto-fill the target context. It conflicts with the `critical_css` contrib module (both decorate the same renderer); `hook_requirements()` raises a runtime error if both are enabled.

---

- Inline only the above-the-fold CSS a given page needs to speed up first paint (FCP/LCP).
- Manage critical CSS from the database through an admin UI rather than editing theme files.
- Attach a CSS fragment to a specific node by ID via the `node:{id}` target context.
- Attach a CSS fragment to every node of a content type via the `node:{bundle}` target context.
- Provide a `default` fallback fragment used when no node-specific match is found.
- Add or edit per-node critical CSS from the "Critical CSS" tab on a node page.
- Add or edit per-content-type critical CSS from the "Critical CSS" tab on a content type's edit page.
- Create critical CSS entries manually with an explicit target context from the admin list page.
- Toggle each entry on or off with its Status field without deleting it.
- Enable or disable the whole feature site-wide from the settings form checkbox.
- Defer non-critical stylesheets to load asynchronously once a critical fragment is inlined.
- Keep print-media stylesheets untouched while other CSS is made async.
- Improve Core Web Vitals on pages built with Layout Builder or Paragraphs.
- Deliver per-landing-page CSS without a theme build step or static critical-CSS files.
- Reduce render-blocking CSS on heavy themes such as Bootstrap or Barrio.
- Skip critical-CSS injection automatically on admin routes and AJAX requests.
- List all critical CSS entries with ID, status, created, and updated columns.
- Delete critical CSS entries individually or in bulk from the list builder.
- Enforce a unique target context per entry so contexts do not collide.
- Let non-developer editors manage critical CSS through simple textarea forms.
- Replace the file-based `critical_css` workflow with a database-driven, editor-friendly one.
- Store and version critical CSS as content entities queryable through Views.
