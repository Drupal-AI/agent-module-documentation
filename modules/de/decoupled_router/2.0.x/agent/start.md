<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# decoupled_router — agent start

Headless-routing helper: one JSON endpoint, **`GET /router/translate-path?path=<path>`**,
that turns any front-end path or alias into the Drupal entity behind it (type, bundle,
id, uuid, label), its `resolved`/`canonical` URLs, redirect info, and — when JSON:API is
enabled — the JSON:API `individual` resource URL. No admin UI, no permissions of its own
(route requires the core `access content` permission), no Drush. Depends on `path_alias`;
optionally uses `redirect` and `jsonapi` if present.

- The endpoint, request params, full JSON response shape, service/event internals → [api/endpoint.md](api/endpoint.md)
- The one setting (`absolute_resolved_urls`) and how to change it → [configure/settings.md](configure/settings.md)
- Alter the resolved payload from your module → [hooks/info-alter.md](hooks/info-alter.md)
