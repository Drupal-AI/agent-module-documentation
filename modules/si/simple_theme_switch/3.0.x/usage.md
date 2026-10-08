<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Forces the site's admin theme onto the user login, password-reminder and password-reset routes, plus any route a hook opts in.

---

By default Drupal renders `/user/login`, `/user/password` and `/user/reset/...` in the front-end theme. This module registers a `theme_negotiator` service (`SimpleThemeSwitchThemeNegotiator`) that `applies()` to exactly those three route names and returns the configured admin theme (`system.theme:admin`) from `determineActiveTheme()`. It also invokes `hook_simple_theme_switch_flag_for_applies_of_admin_theme($route_match, $request)`, so other modules can return TRUE to extend admin-theme rendering to further paths — the shipped `.api.php` example matches Webform submission view routes.

Setup: install the module and set the desired admin theme under Appearance; no configuration form is provided. To cover extra routes, implement the flag hook in a custom module. There are no routes, permissions or config of its own — it is a pure service-tagged negotiator.

---
- Render the user login page in the admin theme.
- Render the password-request page (`/user/password`) in the admin theme.
- Render the password-reset confirmation page in the admin theme.
- Give anonymous auth pages a consistent back-office look.
- Extend admin-theme rendering to Webform submission pages via the flag hook.
- Opt any custom route into the admin theme with `hook_simple_theme_switch_flag_for_applies_of_admin_theme`.
- Match routes by regex on the request path inside the hook.
- Avoid front-end theme styling leaking onto account forms.
- Keep login branding aligned with the administration UI.
- Change the applied theme simply by switching the site admin theme.
- Add the negotiator without writing a settings form.
- Combine with an admin theme like Gin or Claro for login pages.
- Ensure password reset links land on an admin-styled page.
- Present a uniform back-office style for all authentication flows.
- Apply the admin theme without altering the site default theme.
- Cover one-time login links with the admin theme.
- Reduce visual confusion between front-end and account pages.
