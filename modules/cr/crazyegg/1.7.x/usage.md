<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crazy Egg is the official module for injecting the Crazy Egg tracking snippet (heatmaps, scrollmaps, session recordings, A/B tests) into your Drupal pages, controlled entirely from a settings form with your account number, role exclusions and path targeting.

---

The module is a thin third-party-snippet integration: it has no entity, plugin or Drush surface, only a `crazyegg.settings` config object and a settings form at `/admin/config/system/crazyegg` (route `crazyegg.config`, permission `administer crazy egg`). Its settings are `crazyegg_enabled` (int on/off), `crazyegg_account_id` (your numeric Crazy Egg account number), `crazyegg_js_scope` (`header` or `footer` — where the script tag is placed), `crazyegg_paths` (a newline path-pattern list restricting which pages are tracked; empty = everywhere) and `crazyegg_roles_excluded` (role ids whose users are NOT tracked). At render time `hook_page_attachments()` checks that the module is enabled, an account id is set, the current path matches `crazyegg_paths` (via `path.matcher`), and the current user is not in an excluded role; if all pass it attaches the `crazyegg/crazyegg` library. That library is built dynamically in `hook_library_info_build()` from the account id: the numeric id is left-padded to 8 digits and split into `NNNN/NNNN` to form the external async script URL `https://script.crazyegg.com/pages/scripts/NNNN/NNNN.js`. The settings config is registered as a cacheable dependency so changing settings invalidates page caches. No external calls happen server-side — the snippet runs in the visitor's browser.

---

- Add Crazy Egg heatmap tracking to a Drupal site by entering just the account number.
- Turn all Crazy Egg tracking on or off site-wide with a single `crazyegg_enabled` toggle.
- Record session replays of visitors interacting with key landing pages.
- Generate scrollmaps to see how far visitors scroll on long pages.
- Run A/B tests via Crazy Egg without hand-editing theme templates.
- Exclude administrators/editors from tracking so internal traffic doesn't skew data.
- Exclude any specific role (e.g. "staff") from the tracking script via `crazyegg_roles_excluded`.
- Track only marketing landing pages by listing their paths in `crazyegg_paths`.
- Track the whole site by leaving the path list empty.
- Place the script in the header for earliest load, or in the footer to reduce render blocking (`crazyegg_js_scope`).
- Keep the account number in exportable config for staging/production parity.
- Temporarily disable tracking during a site migration without uninstalling the module.
- Add heatmaps to a specific campaign path like `/promo/*` only.
- Ensure the tracking tag auto-invalidates cached pages when settings change (cacheable dependency).
- Avoid writing custom `hook_page_attachments` code — the module handles snippet injection.
- Comply with an internal policy to never track logged-in privileged users.
- Load the Crazy Egg script asynchronously (the library sets `async`).
- Validate the account-number-to-URL mapping (e.g. `1234567` → path `0123/4567`).
- Provide non-developers a UI to manage the tracking tag (permission `administer crazy egg`).
- Roll out heatmaps to a multi-site by deploying the same `crazyegg.settings` config.
- Restrict tracking to anonymous visitors by excluding the authenticated role.
- Quickly confirm whether tracking is active by inspecting `crazyegg.settings`.
- Combine path targeting and role exclusion to precisely scope where and for whom tracking runs.
- Support Drupal 8 through 12 with the same lightweight integration.
