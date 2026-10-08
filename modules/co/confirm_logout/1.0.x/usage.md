<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Confirm Logout inserts a **confirmation step before a user is logged out**, so an accidental click on the
logout link shows a "are you sure?" page instead of ending the session immediately. The confirmation message is
configurable and supports tokens.

Use it to prevent accidental logouts and to present a branded/custom message on logout. It replaces the direct
logout action with a confirm form for logged-in users.
---
- Requires the `token` module; enable with `ddev drush en confirm_logout`.
- Configure at `/admin/config/people/confirm-logout` (permission `administer confirm_logout configuration`).
- Set the confirmation title/message (token-enabled) shown on the confirm page.
- Confirm routes (`/confirm/logout`, `/confirm-logout`) require `_user_is_logged_in: TRUE`.
- Ships its own permission for accessing the configuration form.
- Optionally style the confirm page via the bundled CSS/JS and template.
---
- Prompt users to confirm before logging out.
- Prevent accidental session termination.
- Show a custom, token-enabled logout message.
- Brand the logout confirmation page.
- Restrict configuration via a dedicated permission.
- Limit confirm routes to authenticated users only.
- Provide a cancel path that returns the user to the site.
- Localize the confirmation message.
- Use tokens (e.g. user name, site name) in the message.
- Theme the confirm page with the provided template.
- Integrate with the standard user logout flow.
- Keep the settings deployable as configuration.
- Support config translation of the message.
- Reduce support issues from mis-clicks on logout.
- Apply site-wide to all logged-in users.
- Disable simply by uninstalling the module.
