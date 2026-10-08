# Permissions

Static (`entity_browser.permissions.yml`):

- **administer entity browsers** (`administer entity browsers`) — create/edit/delete
  browsers and gate all `/admin/config/content/entity_browser` routes.
  `restrict access: TRUE` (a trusted-admin permission).

Dynamic (`\Drupal\entity_browser\Permissions::permissions`): for every browser whose
display exposes a route (i.e. `standalone`, and any display where `$browser->route()`
returns a route), a permission is generated:

- **access {browser_id} entity browser pages** — e.g.
  `access sample entity browser pages`. Controls access to that browser's operating
  pages. Carries a config dependency on the browser entity, so it is removed when the
  browser is deleted.

Inline/modal/iframe browsers embedded in a field form are gated by the host form's
access, not by a dedicated permission.
