<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Theme Change selects which installed theme renders which paths or routes, storing each rule as a configuration entity, rather than accepting Drupal's single admin-theme setting.

---

Core's theme negotiation offers essentially one lever: an admin theme applied to administrative routes, optionally extended to node edit forms. Real sites want finer control — a member dashboard that looks like the site rather than like Claro, a heavily-used admin screen better rendered in the front-end theme where the organisation's design system lives, or a stripped theme for a print or landing page. Doing that by hand means writing and maintaining a theme negotiator service. This module makes it configuration instead. After enabling it (it depends only on core `path_alias`), go to `admin/config/system/theme_change` and add a rule: give it a label, choose **Route** or **Path**, enter the route machine name (validated against the router) or a path, and pick any installed theme. Paths accept comma-separated values and wildcards such as `/user/*, /node/*`, and are matched against both the raw path and its path alias; routes are matched by exact route name. Each rule is a `theme_change` **configuration entity**, so rules export with the site's configuration, appear in diffs and are listable, and can be deployed with `drush config:import`. At request time a tagged theme-negotiator service (priority 10) loads every rule and the **first** one that matches wins, so order your rules with that in mind. Version **4.0.1** runs on core `^10 || ^11`. Two things worth weighing: its three permissions (settings, edit, delete pages) are **not** marked `restrict access`, and a theme carries templates and JavaScript, so routing pages into a chosen theme is more consequential than it sounds; and the active theme is part of the render cache key, so a rule change can leave stale rendered output until caches clear (`drush cr`).

---

- Use the front-end theme for a dashboard.
- Render one admin page in a custom theme.
- Keep a member area on-brand.
- Strip navigation from a landing page.
- Apply a theme to a set of paths with a wildcard.
- Override the admin theme per route.
- Avoid writing a theme negotiator service by hand.
- Export theme rules with configuration.
- Theme a checkout differently.
- Use a minimal theme for a print page.
- Apply a theme to a whole section via `/section/*`.
- Match a rule against a path alias, not just the raw path.
- Theme a campaign path.
- Support a distinct staff interface.
- Give a report page a wide layout.
- Match a client portal's branding.
- Test a theme on selected paths before rolling it out.
- Support a multi-brand structure.
- Deploy theme rules across environments with config import.
