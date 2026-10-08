Theme Permission replaces core's single, all-or-nothing `administer themes` permission with **per-theme** permissions, so a role can be allowed to manage (install / uninstall / set default / configure) only specific themes on the Appearance page.

---

Core gates the entire Appearance page and every theme operation behind the one `administer themes`
permission. Theme Permission adds **dynamic, per-theme permissions** — for every installed theme it
generates `administer themes <theme>` and `uninstall themes <theme>`, plus a single
`Edit Administration theme` permission (via `ThemePerm::dynamicPermissions()`, wired through
`theme_permission.permissions.yml`'s `permission_callbacks`). A route subscriber
(`RouteSubscriber`) then overrides the Appearance page (`system.themes_page`) to use the module's own
`AccessController::themesPage()` controller — a copy of core's themes page that only lists and offers
operations for themes the current user has `administer themes <theme>` for — and adds a
`_custom_access` check (`AccessController::access`, keyed on the `theme` query parameter) to the
theme install, uninstall, set-default, per-theme settings, and block-per-theme routes. The admin-theme
selection form at the bottom of the page is shown only to users with `Edit Administration theme`.
Uninstall links additionally require `uninstall themes <theme>`. The module has no configuration
form of its own; its `configure` route is core's `system.themes_page`, and you assign the generated
permissions on the normal `/admin/people/permissions` page.

---

- Let a "designer" role install and configure the Olivero theme but not touch any other theme.
- Allow a sub-site manager to set a specific theme as the default without granting full `administer themes`.
- Grant a role permission to uninstall only one designated theme.
- Give a client role access to a single theme's settings form (logo, colors) and nothing else.
- Delegate management of a marketing theme to a marketing role while protecting the admin theme.
- Restrict who may change the administration theme by gating the `Edit Administration theme` permission.
- Show a limited Appearance page that lists only the themes a given role is allowed to manage.
- Prevent editors from installing or switching arbitrary themes site-wide.
- Support a multi-brand site where each brand team manages its own theme.
- Scope theme block placement (block admin per theme) to roles permitted for that theme.
- Provide least-privilege theme administration in agencies handing partial access to clients.
- Assign `administer themes <theme>` per theme on the standard permissions page.
- Keep the default super-admin (`administer themes`) flow intact while adding finer roles.
- Let a role configure a theme's settings without being able to set it as default.
- Allow a role to install-and-set-default only for an approved theme.
- Audit which roles can manage which themes by reading role permission strings.
- Hide themes a user cannot manage from their Appearance page entirely.
- Combine per-theme install and per-theme uninstall permissions independently for a role.
- Support staging workflows where only certain roles may enable a new theme.
- Reduce risk of accidental theme changes by non-technical administrators.
