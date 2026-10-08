<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Theme lets you force Drupal's administration theme onto any set of front-end paths (and exclude paths), going beyond core's "use the admin theme when editing content" toggle.

---

Core can only apply the admin theme to node-edit pages; Admin Theme replaces that with an arbitrary include/exclude path list. It adds two fields — **Include** and **Exclude** — to the appearance form at `/admin/appearance` (`system_themes_admin_form`) via `hook_form_FORM_ID_alter`, each backed by a core `request_path` condition plugin, and saves the entered paths into the `admin_theme.settings` config object under the keys `paths` and `exclude_paths` (newline-separated path patterns, supporting `*` wildcards and `<front>`). The actual theme switch is done by a service **decorator**: `admin_theme.admin_context` decorates core's `router.admin_context` (`AdminThemeAdminContext`), so `AdminContext::isAdminRoute()` returns TRUE — and therefore the admin theme is used — whenever the current path matches the Include condition and does not match the Exclude condition. Because it hooks the admin-route determination rather than a theme negotiator, it composes with the rest of core's theme system. The module ships a placeholder default path (`/dummy-path-needed-until-core-issue-2930364-is-fixed`) for both keys as a workaround for a core condition-configuration bug. There is no dedicated settings page (the `configure` route is `system.themes_page`), no permissions of its own, no Drush, and no plugins — just the two config keys and the decorator.

---

- Show the admin theme on a custom moderation dashboard at `/company-dashboard` and its sub-pages.
- Apply the admin theme to a reports section (`/reports`, `/reports/*`) for a consistent backend look.
- Use the admin theme across a whole custom admin area that lives outside `/admin`.
- Give editors the admin theme on a front-end path where they manage content.
- Exclude a specific path (e.g. `/node/add/landing_page`) from the admin theme while including its parent.
- Keep the public-facing preview of a node on the default theme by excluding its path.
- Force the admin theme on views-based listing pages you built for staff.
- Apply the admin theme to a group/organic-groups management path.
- Match many paths at once with wildcard patterns like `/team/*/manage`.
- Include `<front>` so the front page uses the admin theme for logged-in staff.
- Exclude the login or user pages from the admin theme.
- Roll out a backend theme to a legacy path structure without writing a theme negotiator.
- Combine include + exclude lists to fine-tune exactly where the admin theme appears.
- Deploy the include/exclude configuration as exportable config (`admin_theme.settings`).
- Standardise the editorial experience by putting all content-management screens on one theme.
- Apply the admin theme to a commerce back-office path.
- Provide a distraction-free admin look on a custom wizard/multi-step form path.
- Switch a section to the admin theme temporarily by editing the include list.
- Avoid core's limitation of only theming node edit forms with the admin theme.
- Use the admin theme on taxonomy or media management paths you exposed to editors.
