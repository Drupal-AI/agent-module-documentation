<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Frontpage for Authenticated users (authenticated_frontpage) — agent index

Gives logged-in users a different front page from anonymous visitors. When an authenticated
user requests the site front page (`/`), a kernel-request event subscriber issues a **302
redirect** to an admin-configured node or internal path; the target page is then flagged as
the front page so the theme renders it like the homepage. Optionally redirects anonymous
users away from that authenticated front page. Targeting can be limited to selected roles.

No dependencies beyond core. `core_version_requirement: ^8 || ^9 || ^10 || ^11`.
Settings page: `/admin/config/system/authenticated-frontpage` (route
`authenticated_frontpage.settings_form`). Defines one permission, no drush, no plugins,
no config schema.

Solutions:
- **Set the authenticated front page and how it targets users** → [configure/settings.md](configure/settings.md)
- **Grant who may change the setting** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object: `authenticated_frontpage.settings`. Nested keys under the
  `authenticated_frontpage.` prefix: `field_loggedin_frontpage` (node id),
  `field_loggedin_frontpage_path` (internal path string), `field_is_path` (bool: use path
  vs node), `field_roles` (checkboxes map of role id => id-or-0), `field_redirect_anonymous` (bool).
- Event subscriber service: `authenticated_frontpage.event_subscriber`
  (class `Drupal\authenticated_frontpage\EventSubscriber\AuthenticatedFrontpageSubscriber`),
  handles `KernelEvents::REQUEST`.
- Theme hook: `authenticated_frontpage_preprocess_page()` sets `$variables['is_front'] = TRUE`
  when the request carries the `is_authenticated_front` attribute.
- Permission: `administer authenticated_frontpage configuration` (`restrict access: true`).
- Route/form: `authenticated_frontpage.settings_form` → `Drupal\authenticated_frontpage\Form\SettingsForm` (form id `authenticated_frontpage`).
