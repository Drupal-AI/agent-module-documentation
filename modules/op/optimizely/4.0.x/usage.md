<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optimizely loads Optimizely-hosted A/B-testing JavaScript snippets onto selected paths of your Drupal site, managed as reusable "project" entries so each experiment only loads where it's needed.

---

The module integrates the third-party Optimizely (formerly Optimizely X / Visual Website Optimizer) experimentation service. You store your Optimizely **account ID** once (config `optimizely.settings:optimizely_id`, form at route `optimizely.settings`), then create one or more **Optimizely project** config entities (entity type `optimizely`, config `optimizely.optimizely.<id>`). Each project has a `label`, a numeric Optimizely **`code`** (the project/experiment id), a `state` (enabled boolean), and a `paths` value — a newline-separated list of Drupal path patterns (with `*` wildcards; `*` alone means sitewide). On every page render `hook_page_attachments()` loads all enabled projects, matches the current path (checking both system paths and URL aliases via the `optimizely.lookuppath` service) against each project's paths, and when one matches injects `<script src="//cdn.optimizely.com/js/<code>.js">` into the page head. A shipped **Default** project (id `default`, paths `*`) provides sitewide loading and cannot be deleted, only disabled. Splitting experiments across multiple path-targeted projects keeps each hosted JS file small and avoids running unused experiment code on every page. Projects are managed from an entity list at `/admin/config/system/optimizely` (add/edit/delete/settings), all gated by the `administer optimizely` permission. Path changes trigger cache-tag invalidation (`optimizely:<path>`) via the `optimizely.cacherefresher` service.

---

- Load a sitewide Optimizely experiment via the Default project's `*` path.
- Run an A/B test only on the homepage by targeting the `/node/1` or `<front>` path.
- Load an experiment only on `/products/*` so product-page tests don't run elsewhere.
- Keep several experiments in separate projects to minimize each hosted JS file's size.
- Disable an experiment temporarily by toggling a project's `state` without deleting it.
- Target a campaign landing page path with its own Optimizely project code.
- Store the Optimizely account ID centrally so the default project can go sitewide.
- Add multiple Optimizely project codes, each scoped to different sections of the site.
- Match paths by URL alias as well as system path (the module resolves both).
- Exclude the bulk of the site from experimentation by narrowing project paths.
- Reduce page-load impact by not loading Optimizely JS on pages with no active test.
- Re-use the original project code sitewide while adding narrower projects for specific areas.
- Roll out a test to a path pattern like `/blog/*` for all blog posts.
- A/B test a checkout flow by targeting the checkout path only.
- Manage experiment targeting entirely from Drupal config entities (exportable).
- Invalidate page caches automatically when experiment paths change.
- Wildcard-target a language or section prefix (e.g. `/es/*`).
- Enable/disable the sitewide default while adding path-specific overrides.
- Track which paths an experiment loads on for auditing via project config.
- Deploy experiment targeting between environments via config export/import.
- Add Optimizely to a marketing site without hand-editing the theme's head markup.
- Provide editors a managed UI to add project codes instead of pasting script tags.
- Limit experiment JS to authenticated or specific paths to control blast radius.
- Point the snippet at Optimizely's CDN (`//cdn.optimizely.com/js/<code>.js`) automatically.
