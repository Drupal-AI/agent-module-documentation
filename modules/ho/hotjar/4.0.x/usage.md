Hotjar adds the Hotjar analytics JavaScript tracking snippet to your Drupal pages so Hotjar can record heatmaps, session recordings and user-behaviour data, with control over which pages and user roles are tracked.

---

You enter your Hotjar site ID ("Hotjar ID" / `hjid`) on the settings form at
`/admin/config/system/hotjar` (route `hotjar.admin_settings_form`, permission
`administer hotjar`); everything is stored in the `hotjar.settings` config object. Nothing is
output until an `account` (ID) is set. The snippet is emitted from
`hook_page_attachments()`: the `hotjar.access` service decides per request whether to add it,
and the `hotjar.snippet` service builds/attaches it. Two attachment modes exist —
`build` (default): the activation script is written to a JS file at `snippet_path`
(`public://hotjar/hotjar.script.js`, regenerated on `hook_rebuild` / cache rebuild) and added
as a `<script src>` in the head; and `drupal_settings`: the ID/version are passed via
`drupalSettings` and the `hotjar/hotjar` library runs it. Visibility is filtered by path
(`visibility_pages`: 0 = all pages *except* the listed `pages`, 1 = *only* the listed pages,
2 = none) and by role (`visibility_roles` + `roles`), and tracking is always suppressed on 403
and 404 responses. The default `pages` list excludes admin, batch, node add/edit and
user sub-pages. It integrates with `eu_cookie_compliance` (skips output when the snippet path
is in the disabled-scripts list) and exposes hooks (`hook_hotjar_access`,
`hook_hotjar_access_alter`, `hook_hotjar_settings_alter`, `hook_hotjar_snippet_alter`) so other
modules can veto tracking, override the ID per host, or wrap the script (e.g. for consent).

---

- Add Hotjar heatmap / session-recording tracking to a Drupal site by entering the Hotjar ID.
- Track every page except admin, node-edit and user account pages (the shipped default).
- Restrict tracking to a specific set of pages (landing pages, product pages) only.
- Exclude additional paths (e.g. `/checkout/*`, `/user/*`) from tracking.
- Track only anonymous visitors and exclude logged-in editors by role.
- Track only certain roles (e.g. a "beta tester" role) and no one else.
- Switch between file-based (`build`) and `drupalSettings`-based snippet delivery.
- Regenerate the tracking JS file after changing the ID via a cache rebuild.
- Disable tracking on 403/404 error pages automatically.
- Suppress the snippet until cookie consent is given via eu_cookie_compliance integration.
- Veto tracking on the front page (or any condition) with `hook_hotjar_access()`.
- Force-disable tracking under custom logic with `hook_hotjar_access_alter()`.
- Serve a different Hotjar ID per hostname/environment with `hook_hotjar_settings_alter()`.
- Wrap the activation script for a custom consent gate with `hook_hotjar_snippet_alter()`.
- Keep the Hotjar ID out of code by managing it in config (`hotjar.settings.account`).
- Roll tracking out to production only by setting the ID in the production config override.
- Bump the Hotjar snippet version (`snippet_version`) when Hotjar changes their embed.
- Point the generated snippet file to a custom path (`snippet_path`).
- Gate access to the tracking configuration behind the `administer hotjar` permission.
- Translate the Hotjar ID per language (config translation support is provided).
- Combine with other analytics/tag modules without conflicting (separate config + attachments).
- Confirm on a live page whether the Hotjar snippet is being emitted for the current request.
