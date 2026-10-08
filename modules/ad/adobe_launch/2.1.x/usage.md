Adobe Launch Snippet Manager injects an Adobe Launch (Adobe Experience Platform tag management) script tag into the `<head>` of rendered pages, with per-environment snippet URLs and path-based inclusion/exclusion rules.

---

The module stores dev/staging/prod Adobe Launch script URLs and a target environment; `hook_preprocess_html` injects the selected environment's protocol-relative script into the page head (optionally `async`) when enabled and the current path passes the rule check. A path rule set (textarea of paths with `*` wildcards) plus an include/exclude toggle (`paths_negate`) decides which pages get the snippet — by default it *excludes* admin and node-edit paths. An optional data-layer initializer library can be attached (`window.digitalData = { events: [] }; window.DTM_DATA = window.DTM_DATA || [];`). Configuration lives at Configuration → Services → Adobe Launch (permission `administer site configuration`); the settings form validates each URL with the core path validator (requiring an external URL) and stores the target environment, async flag, initializer flag, registrant email, paths, and negate flag. A `hook_adobe_launch_path_check_alter` lets other modules override the per-request inclusion decision. There are no permissions, plugins, or Drush commands of its own.

---

- Add the Adobe Launch tag-management snippet to the site head without editing templates.
- Serve different Launch script URLs for dev, staging, and production from one config.
- Switch the active environment (dev/staging/prod) with a single select.
- Load the Launch script asynchronously (recommended) or synchronously.
- Exclude the snippet from admin and node-edit pages by default.
- Restrict the snippet to a specific set of paths using include mode.
- Exclude the snippet from chosen paths using exclude mode with `*` wildcards.
- Initialize the Adobe data layer (`window.digitalData` / `window.DTM_DATA`) before the snippet runs.
- Record the registrant email for the Adobe Launch subscription.
- Keep analytics tags out of editorial/admin contexts to avoid skewing data.
- Roll out Launch to only a section of the site (e.g. `/products/*`) via path rules.
- Let another module programmatically alter whether the snippet loads via the alter hook.
- Manage the snippet centrally so marketers don't need theme access.
- Use protocol-relative URLs so the script matches the page scheme.
- Turn the whole integration on/off with a single "Enable Adobe Launch" checkbox.
- Validate Launch URLs on save so malformed script URLs are rejected.
- Deploy environment-specific settings via config override in settings.php.
