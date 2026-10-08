<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cache Buster is a development helper that alters how CSS files are emitted so browsers always fetch fresh copies. Via `hook_css_alter()` it flips every non-external CSS file to `type = external` and prefixes its path with `/`, which bypasses Drupal's normal CSS aggregation/caching so front-end changes show up immediately. It also prints a warning message reminding you to uninstall it outside of development.

Use it only during active front-end/theme development.
---
Enable with `drush en cachebuster`. There is no configuration UI, no routes, and no permissions — the behavior is entirely in `cachebuster_css_alter()` in `cachebuster.module`.

Because it disables CSS aggregation and shows an admin warning on every request, it is explicitly intended to be uninstalled before going to production.
---
- See CSS changes immediately during theme development.
- Bypass CSS aggregation while iterating on styles.
- Avoid manual cache clears after each CSS edit.
- Force browsers to refetch stylesheets.
- Speed up front-end debugging feedback loops.
- Rewrite internal CSS as external references.
- Get a reminder warning to uninstall in production.
- Prototype design changes without cache friction.
- Pair with a local dev environment for live CSS work.
- Disable stylesheet caching site-wide temporarily.
- Reduce confusion from stale cached CSS.
- Support D8/D9/D10 dev workflows.
- Drop into a build only during a styling sprint.
- Confirm which CSS files load without aggregation.
- Simplify CSS troubleshooting for themers.
- Toggle on/off by enabling/disabling the module.