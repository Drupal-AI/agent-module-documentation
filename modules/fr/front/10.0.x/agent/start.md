<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Front Page (front) — agent index

**Machine name `front_page`.** Overrides the site front page per user role: when a role has an
override enabled, a request to the front page is 302-redirected to an admin-configured local path.
Separately overrides where `<front>` HOME links point. Version **10.0.0-beta1**, core `^10 || ^11`,
no non-core dependencies. Configure route: `front_page.settings` (`/admin/config/system/front`).

- **Role-based front page override (settings form, config keys, runtime redirect)** →
  [configure/settings.md](configure/settings.md)
- **HOME link (`<front>`) redirect override** → [configure/home-links.md](configure/home-links.md)
- **The permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Single config object `front_page.settings`: `enabled` (bool), `disable_for_administrators` (bool),
  `home_link_path` (path), `roles.<role_id>.{enabled(bool),weight(int),path(path)}`.
- Runtime engine: `Drupal\front_page\EventSubscriber\FrontPageSubscriber::initData()` (service
  `front_page.event_subscriber`) on `KernelEvents::REQUEST` — picks the enabled role override with the
  lowest `weight` and issues a `RedirectResponse`.
- `Drupal\front_page\FrontPagePathProcessor::processOutbound()` (service
  `front_page.front_page_path_processor`, `path_processor_outbound` tag) rewrites `/<front>` and empty
  outbound paths to `home_link_path`.
- Two config forms: `Drupal\front_page\Form\FrontPageSettingsForm` (id `front_page_admin`) and
  `Drupal\front_page\Form\FrontPageHomeLinksForm` (id `front_page_admin_home_links`).
- One permission: `administer front page` (restrict access). No Drush, no plugin types, no submodules.
- `hook_user_role_delete` clears a deleted role's override; `hook_help` provides help text;
  `front_page_update_8101` migrates legacy `enable`/`rid_*` keys to `enabled`/`roles.*`.
