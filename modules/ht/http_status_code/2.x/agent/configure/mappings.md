<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring path → status mappings

**Add a mapping:** `/admin/config/http_status_code/http_status_entity/add`
(`HTTPStatusEntityForm`). Provide a label, the URL/path to match and the status
code to return. Mappings are `http_status_entity` config entities and are
exported with config. List/edit/delete at
`/admin/config/http_status_code/http_status_entity`.

**How matching works:** on every response `HTTPStatusSubscriber::onRespond()`
compares the entity `url` against `Request::getRequestUri()`
(`loadByProperties`) and, on a hit, overrides the response status code. Matching
is exact against the request URI, so include the leading slash and any query
string exactly as requested.

**Typical use:** set `410` for a permanently removed page so search engines
deindex it; the help text explicitly calls this out.

**Access note:** the CRUD routes require the `administer http status code`
permission. The separate settings form
(`/admin/config/http_status_code/settings`, `_access: 'TRUE'`) is **not**
permission-gated — it only exposes an unimplemented `automatic_410` toggle, but
restrict it (add a `_permission` requirement) before relying on this module in
production.
