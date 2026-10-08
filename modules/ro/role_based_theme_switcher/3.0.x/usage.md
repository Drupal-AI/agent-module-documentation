Role Based Theme Switcher lets you assign a different active (front-end) theme per user role, with a drag-and-drop weight that resolves which theme wins when a user holds several roles.

---

The module registers a theme negotiator service (`theme.negotiator.role_based_theme_switcher`, priority 10) that, on each request, reads the `role_based_theme_switcher.RoleBasedThemeSwitchConfig` config (a `roletheme` map of role → `{id: theme, weight}`), determines the current user's highest-weight matching role, and returns that role's theme as the active theme. An admin settings form at `/admin/config/system/role_based_theme_switcher/settings` (permission `administer site configuration`) lists all roles in a `tabledrag` table where each row picks a theme from the installed themes list and a weight; the row dragged lowest (highest weight) wins for users with multiple roles. The negotiator explicitly steps aside on admin routes when the user has the `view the administration theme` permission, so the configured admin theme still applies there; on all other routes (and admin routes for users without that permission) the role-based theme is applied. Saving the form calls `drupal_flush_all_caches()` so anonymous/page caches pick up the change. The module has no config schema (config is stored untyped), no permissions of its own, and no Drush; note the built-in defaults reference the legacy `seven`/`bartik` theme names, which do not exist on Drupal 10/11, so you must pick real installed themes in the form.

---

- Give administrators/editors a different admin-adjacent front-end theme than anonymous visitors.
- Serve a distinct theme to a "premium" or "member" role.
- Preview a redesign by assigning the new theme to a single test role.
- Brand a partner/reseller role with its own theme on a shared site.
- Apply a high-contrast or accessibility theme to a specific role.
- Use role weight to make the correct theme win for users holding multiple roles.
- Keep the standard administration theme on admin pages via the `view the administration theme` opt-out.
- Assign a stripped-down theme to a limited-access role (e.g. kiosk users).
- Differentiate staff vs. customer experiences without separate sites.
- Roll out a beta theme to beta-tester role members only.
- Give the anonymous/authenticated baseline one theme and elevate specific roles to another.
- Switch theme for a "support agent" role to a denser UI theme.
- Apply seasonal/campaign theming to a marketing role.
- Provide a demo role that shows a showcase theme.
- Centrally manage per-role theming from one settings form instead of custom negotiator code.
- Ensure theme changes take effect immediately for anonymous users (cache flush on save).
- Combine multiple roles with drag-and-drop priority to encode a theme precedence order.
- Assign the default site theme to most roles and override just one or two.
