<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Response Headers — agent index

Add, change, or remove any HTTP response header via config entities, focused on security &
performance headers. Each header is a `response_header` config entity; a response subscriber
applies the enabled ones (empty value ⇒ header removed).

- **Config entity shape, routes, add/remove a header, shipped defaults, visibility** →
  [configure/headers.md](configure/headers.md)
- **How headers are applied/removed at response time, event & priority** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Configure route `entity.response_header.collection` → `/admin/config/system/response-headers`.
  Add form `entity.response_header.add_form` → `/admin/config/system/response-headers/add`.
- Config entity prefix `http_response_headers.response_header.<id>`; key fields:
  `name` (HTTP header), `value`, `status`, `visibility` (core condition plugins), `label`,
  `description`. `config_export` excludes `status` handling to the entity system.
- **Empty `value` on an enabled entity removes that header** from the response.
- Permissions: `administer http response headers`, plus `add` / `edit` / `delete http response headers`.
- Ships 10 optional default headers (X-Frame-Options, CSP, HSTS, Referrer-Policy, …).
- No Drush commands; no plugin types (reuses core condition plugins for visibility).
