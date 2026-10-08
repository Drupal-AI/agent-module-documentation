Modern Drupal Dashboard (Dash) replaces the default admin landing page with a React-powered dashboard at /admin/dashboard that surfaces content, user, module, entity, system, and health metrics.

---

Dash ships one admin route (`/admin/dashboard`, permission `access modern dashboard`) that renders a container hydrated by a bundled React single-page app, plus a JSON data route (`/admin/dashboard/data/{widget}`) that exposes eleven read-only widget endpoints. Backend logic lives in small, single-purpose services (`ContentDataService`, `UsersDataService`, `EntitiesDataService`, `StatusDataService`, `ModulesDataService`, `HealthDataService`, `ModuleCatalog`) aggregated behind a `DashboardData` facade. Every payload is returned as a `CacheableJsonResponse` with per-widget cache tags, a `user.permissions` cache context, and a short max-age. All entity queries run with `accessCheck(TRUE)` and every endpoint is gated behind the single restricted permission, so the dashboard only ever reports aggregate counts and health indicators — never per-record content. There is no settings form, no config schema, and no dependency beyond core `system` (individual checks light up when optional modules such as media, metatag, dblog, or update are present).

---

- Give site administrators a single modern overview page at `/admin/dashboard` instead of the stock admin index.
- Add a top-level "Dashboard" menu link (weight -20) under the admin menu for one-click access.
- See total node count with a published vs. unpublished split at a glance (Content tile).
- Drill into per-content-type node counts with published/unpublished breakdown on the Content detail page.
- Audit content hygiene: nodes unpublished for more than 30 days, nodes without images, nodes missing meta tags (when Metatag is enabled), untranslated nodes (multilingual sites), and recently edited but still unpublished nodes.
- Inventory "additional content": taxonomy `tags` terms, custom blocks, media items (when Media is enabled), and managed files.
- Track total active users plus a live "online in the last 15 minutes" count (Users tile).
- Break down active users by role with a pie-chart-friendly payload (users with multiple roles counted in each role).
- Audit users: inactive for 90+ days, users with multiple roles, users created this week, and users who have never logged in.
- List every entity type (content and config) with its count and a direct "Manage" collection link for audits.
- Show installed vs. enabled module counts (Modules tile) and a detailed modules listing.
- Surface contrib projects with available updates (when the Update module is enabled), development modules that are enabled (devel, webprofiler, views_ui, dblog, etc.), and modules present in composer.json but disabled.
- Display a system snapshot: Drupal core version, PHP version, PHP memory limit, database type/version, web server, and last cron run.
- Summarize core requirements (from the status report) as checked / warnings / errors counts.
- Compute SEO health from checks for Metatag, Pathauto, a sitemap module, robots.txt crawlability, llms.txt presence, and Schema.org Metatag.
- Compute performance health from page caching, Devel-off, BigPipe, CSS/JS aggregation, cron freshness, queue backlog, recent error/critical log rate, a persistent cache backend, and AdvAgg.
- Compute accessibility health from Editoria11y, CKEditor A11y checker, image-media alt-text coverage, and an accessible admin theme (Claro/Gin).
- Compute security health from Seckit, Honeypot, CAPTCHA/reCAPTCHA, Password Policy, a configured private files path, absence of risky contrib modules, and Automated Cron.
- Give each health category a 0–100 score plus a detailed pass/fail check list on the Health detail page.
- Use the JSON widget endpoints as a lightweight, cache-friendly read API for building custom admin tooling.
