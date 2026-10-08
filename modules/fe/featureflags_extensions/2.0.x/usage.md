<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extends the Feature Flags module so a feature flag can switch routes and permissions on and off, plus a Twig function to test a flag in templates.

---

Feature Flags Extensions is an add-on for the contrib Feature Flags (`featureflags`) module (it requires
`drupal/featureflags:^2.0` and Drupal 11). It adds two per-flag admin forms — a Routes tab and a Permissions
tab — to every feature flag. On the Routes tab you list route machine names (one per line); on the Permissions
tab you tick permissions. Those bindings are stored in two config entity types (`featureflags_routes` and
`featureflags_permissions`, both keyed by the flag id) and export to configuration, so they travel through your
normal deployment workflow. While a flag is turned off, a route event subscriber makes each of its bound routes
unavailable and a core `permission_checker` decorator makes each of its bound permissions unavailable; when the
flag is on, those routes and permissions behave exactly as core would. The module also registers a
`featureflag_active("<flag_id>")` Twig function so templates can render flag-dependent markup. It has no settings
page of its own — bindings are edited on each flag under Configuration → Development → Feature Flags — and it
ships no external HTTP integration, credentials or Drush commands.

---

- Hide an admin or feature route while its feature flag is turned off, and expose it again by turning the flag on.
- Roll a new page or controller out gradually by tying its route to a feature flag.
- Take a permission away from all roles while a flag is off, without editing the permissions matrix.
- Gate a set of permissions behind a single feature flag for a coordinated feature launch.
- Keep route/permission gating in exported configuration so it deploys with the rest of the site.
- Add a "Routes" and a "Permissions" tab to every feature flag for operators to manage bindings.
- List several route machine names (one per line) that a single flag should control.
- Tick multiple permissions on a flag's Permissions form to switch them together.
- Show or hide markup in a Twig template based on a flag with `{% if featureflag_active("demoflag") %}…{% endif %}`.
- Wrap a Twig block, region or component so it only renders when a feature flag is active.
- Kill-switch a risky feature in production by flipping its flag off (routes and permissions go with it).
- Coordinate a feature that spans several routes and permissions behind one on/off toggle.
- Manage the route/permission bindings from a dedicated admin listing (`featureflags_routes` / `featureflags_permissions`).
- Delegate flag toggling and binding management to trusted operators via dedicated admin permissions.
- Keep per-flag route and permission definitions versioned alongside the flag itself.
- Clean up a flag's bindings automatically when the flag is deleted.
- Test flag-driven route/permission behavior in a dev environment before enabling in production.
- Reuse the same feature-flag toggle across templates, routes and permissions for one feature.
- Standardise how features are gated across a site instead of ad-hoc access checks.
- Provide editors a single feature-flag switch that also controls which pages are reachable.
- Bind a Views page or custom controller route to a flag by its route name.
