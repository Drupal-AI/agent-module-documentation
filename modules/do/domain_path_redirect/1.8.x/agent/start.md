<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Path Redirect (domain_path_redirect) — agent index

Makes the Redirect module domain-aware. Adds a `domain_path_redirect` content entity (a
subclass of Redirect's entity with an extra `domain` reference) so the same source path can
redirect to a different destination on each domain of a Domain Access site. A KernelEvents::REQUEST
subscriber matches the incoming path against the active domain and issues the redirect.

Dependencies: `domain:domain`, `redirect:redirect (>= 1.12.0)`. Composer: `drupal/redirect ^1.12`,
`drupal/domain ^1.0 || ^2.0`.

No settings form of its own (`configure` route is null; `data.json.configure` = null). Admin UI is
the entity list at `/admin/config/search/domain_path_redirect`. Defines NO permissions of its own —
it reuses Redirect's `administer redirects` for every route and as the entity `admin_permission`.
No drush commands. No plugin *types* (it defines one Views filter plugin).

- **Create / list / edit / delete per-domain redirects (routes, entity fields, drush/PHP)** → [configure/redirects.md](configure/redirects.md)
- **How a redirect is resolved and issued at request time** → [events/redirect_subscriber.md](events/redirect_subscriber.md)
- **Look up redirects programmatically (the repository service)** → [api/repository.md](api/repository.md)
- **The redirect-source widget alter it implements** → [hooks/field_widget_alter.md](hooks/field_widget_alter.md)
- **The default admin view + `domain_autocomplete` filter** → [views/views.md](views/views.md)

Key facts:
- Entity type id `domain_path_redirect`, class `Drupal\domain_path_redirect\Entity\DomainPathRedirect`
  extends `Drupal\redirect\Entity\Redirect`. `base_table: domain_path_redirect`,
  `translatable: FALSE`, `admin_permission: administer redirects`. Default bundle
  `domain_path_redirect` (bundle_label "Redirect type").
- Entity keys: `id=rid`, `label=redirect_source`, `bundle=type`, `langcode=language`,
  `published=enabled`, `domain=domain`, `uuid=uuid`.
- Extra base field `domain` (entity_reference → `domain`), default = active domain via
  `domain.negotiator::getActiveId()`. `enabled` (boolean, default TRUE) is the published key.
  `hash` (from Redirect) is recomputed in `preSave()` to include the domain.
- Services: `domain_path_redirect.repository` (`DomainPathRedirectRepository`, backend_overridable),
  `domain_path_redirect.request_subscriber` (`DomainPathRedirectRequestSubscriber`, event_subscriber).
- Routes: `domain_path_redirect.list`, `domain_path_redirect.add`,
  `entity.domain_path_redirect.canonical` / `.edit_form` / `.delete_form` — all under
  `/admin/config/search/domain_path_redirect`, gated by `administer redirects` / entity access.
- Config: schema `views.filter.domain_autocomplete`; default view `views.view.domain_path_redirect`
  (install); optional `language.content_settings.domain_path_redirect.redirect`. No config *object*
  of its own (it reads `redirect.settings`).
- Library `domain_path_redirect/drupal.domain_path_redirect.admin` (admin CSS).
- Update hooks: `_update_8100` (reimport config), `_8101` (fix bundle name in `redirect` table),
  `_8102` (add `enabled` field + published key).
