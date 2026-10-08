Siteimprove Analytics injects the Siteimprove Analytics JavaScript tracker (`https://siteimproveanalytics.com/js/siteanalyze_<code>.js`) into every page, gated by a configurable "track for" audience and an excluded-routes filter.

---

A small integration module: on `hook_library_info_build` it defines an external, async JS library pointing at `https://siteimproveanalytics.com/js/siteanalyze_<code>.js`, where `<code>` is the numeric application code from your Siteimprove dashboard. On `hook_page_attachments` it decides whether to attach that library based on two settings: `user_filter` (`anonymous` | `logged_in` | `everyone`) and `routes_filter` (a newline-separated path-pattern list, wildcards allowed, whose matches are excluded from tracking). The current path is resolved through its alias before matching. The single config object `siteimprove_analytics.settings` holds `code`, `user_filter`, and `routes_filter`; the settings form at `/admin/config/system/siteimprove-analytics` (route `siteimprove_analytics.settings`, permission `administer siteimprove_analytics`) validates that `code` is numeric. Cacheability is handled with `url.path` + config dependency, and `user.roles:anonymous` when not tracking everyone. Default excluded routes cover `/admin`, `/admin/*`, `/batch`, node add/edit/delete, and user edit/cancel. The tracker only loads when a `code` is set. Hook logic lives in autowired service classes (`AnalyticsHooks`, `LibraryHooks`); values can also be set from `settings.php` via `$config['siteimprove_analytics.settings'][...]`.

---

- Add Siteimprove Analytics page tracking to a Drupal site without editing templates.
- Configure the numeric Siteimprove application code via the admin form or `settings.php`.
- Track only anonymous visitors (default) to exclude staff/editors from analytics.
- Track only authenticated users when you specifically want logged-in behavior.
- Track everyone (all users) on public-facing sites.
- Exclude admin pages from tracking with the default `/admin` + `/admin/*` route filters.
- Exclude batch, node add/edit/delete, and user edit/cancel routes from tracking (default).
- Add custom excluded routes (wildcards supported, one per line) for sections you don't want tracked.
- Match paths by alias — aliased URLs are resolved before the route filter is applied.
- Keep the tracker off entirely until a code is entered (empty code = no script).
- Set the code/filters in code (`settings.php`) for per-environment overrides (e.g. staging off).
- Load the tracker asynchronously so it doesn't block page rendering.
- Ensure the script is cached correctly per path and per anonymous/authenticated role.
- Restrict who can change tracking settings via the `administer siteimprove_analytics` permission.
- Validate the application code is numeric to avoid a malformed tracker URL.
- Roll out consistent Siteimprove tracking across a multisite via shared config.
- Turn tracking on/off per environment by toggling the code value.
- Provide privacy-aware analytics by excluding sensitive routes and limiting the audience.
