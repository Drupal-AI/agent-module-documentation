<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Entity Edit Redirect

Route `entity_edit_redirect.admin_form` at `/admin/config/content/entity_edit_redirect`, permission `admininister entity edit redirect configuration` (misspelled in the module's routing/permission).

Config object `entity_edit_redirect.settings`:
- `base_redirect_url` — external host to redirect edit forms to (e.g. `https://editor.example.com`). Empty disables all redirects.
- `append_destination` (bool) — append the Drupal return URL as a query string.
- `destination_querystring` — the query key used for the appended destination (default `destination`).
- `entity_edit_path_patterns` — map of `entity_type` or `entity_type.bundle` to a path pattern; `{uuid}` is replaced with the entity UUID.

Textarea input format on the form: one rule per line, `entity_type[.bundle]:path/pattern/{uuid}`.

Behaviour: on any route `entity.{entity_type}.edit_form` with one route parameter, if a pattern matches the entity, the subscriber issues `new TrustedRedirectResponse(base + '/' + path, 301)`. Destination resolution order for the appended return URL: `?destination=` query, same-origin `referer`, entity canonical URL, site base URL.
