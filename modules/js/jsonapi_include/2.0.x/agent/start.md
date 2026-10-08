<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Include — agent index

Flattens `include`-d related entities into the parent resource's fields in JSON:API responses, so
clients don't have to stitch the `included` array. A response subscriber runs the
`jsonapi_include.parse` service over any body starting with `{"jsonapi"`.

- **The one setting (`use_include_query`), its route, and default behavior** →
  [configure/settings.md](configure/settings.md)
- **What the response looks like before vs after flattening** → [api/response-shape.md](api/response-shape.md)
- **Customize the parsing (override the service / subclass `JsonapiParse`)** →
  [extend/custom-parser.md](extend/custom-parser.md)

Key facts:
- Depends on core `jsonapi` (+ `user`). No permissions, no Drush, no plugins.
- Default: **every** JSON:API response is flattened. Set `use_include_query: true` to require
  `?jsonapi_include=1` per request (opt-in).
- Config object: `jsonapi_include.settings` → `use_include_query` (boolean, default `false`).
  Form route `jsonapi_include.settings` at `/admin/config/services/jsonapi/include`.
- Services: `jsonapi_include.response` (KernelEvents::RESPONSE subscriber) and
  `jsonapi_include.parse` (`Drupal\jsonapi_include\JsonapiParse` implements `JsonapiParseInterface`).
  Adds cache context `url.query_args:jsonapi_include`.
