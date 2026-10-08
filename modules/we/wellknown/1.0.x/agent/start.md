<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Well-Known Paths (wellknown) — agent index

Define `/.well-known/<name>` URLs and their response bodies from Drupal configuration
instead of placing static files in the docroot. An admin edits a list of name/value
pairs; a route subscriber turns each into a live, anonymous `/.well-known/<name>` route
served by a tiny controller.

- Dependencies: none. Core requirement `^10 || ^11`.
- Configure route: `wellknown.settings_form` → `/admin/config/development/well-known`
  (gated by core permission `administer site configuration`; no permission of its own).
- Defines no plugin type, no drush commands, no permissions. **Release 1.0.0-alpha2 (alpha).**

Solutions:
- **Add / edit / remove a well-known path and its content** → [configure/paths.md](configure/paths.md)
- **Set the paths from code or drush, or trace how a URL gets served** → [configure/paths.md](configure/paths.md)

Key facts:
- Config object `wellknown.settings`, key `paths` — a sequence of `{name, value}`.
  Default is empty (`paths: [ ]`), so the module serves nothing until you add a path.
- Routes are **generated dynamically** from that config by
  `Drupal\wellknown\Routing\WellKnownRouteSubscriber` (service `wellknown.route_subscriber`,
  an `event_subscriber`). The static `wellknown.routing.yml` only declares the settings
  form — grepping it will not show the paths a site actually serves; read the config
  (`drush cget wellknown.settings`).
- Each generated route: name `wellknown.<name>`, path `/.well-known/<name>`,
  `_access: 'TRUE'` (anonymous, as RFC 8615 well-known URIs are meant to be), defaults
  `content` = the stored value; served by
  `Drupal\wellknown\Controller\WellKnownController::response($content)` as a plain
  `Response` (no explicit Content-Type → defaults to `text/html`).
- Saving the form calls `router.builder->rebuild()` so new/removed paths take effect at once.
- **Unusual layout:** schema lives in `schema/wellknown.schema.yml` and default config in
  `install/wellknown.settings.yml` — not the core-standard `config/schema/` and
  `config/install/`, so core discovers neither at runtime (see configure/paths.md).
