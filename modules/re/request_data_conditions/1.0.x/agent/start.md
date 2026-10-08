<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request Data Conditions (request_data_conditions) — agent index

Four **condition plugins** that test the current HTTP request's **cookies, HTTP headers, URL query
parameters and session values** for block / section / Context visibility. Each condition holds a list
of `{name, op, value}` rules plus a **Require all** flag (AND vs OR). No dependencies, no routes, no
permissions, no config page, no config schema, no plugin types of its own — it only *implements*
core's `Condition` plugin type.

- Core: `^9.3 || ^10 || ^11`. Package: none. **Current release 8.x-1.0-beta3 (beta).**
- The four plugin ids: `cookie_values`, `http_headers`, `url_query_parameters`, `session_values`
  (all extend `Drupal\request_data_conditions\Plugin\Condition\BaseCondition`).
- Configured entirely from the host UI where you add a condition (block visibility, Layout Builder,
  [Context](https://www.drupal.org/project/context)); nothing to set up centrally after enabling.

## What you'd do → where

- **Add and configure one of the conditions (fields, operators, Require-all, regex, where they
  appear)** → [configure/request_data_conditions.md](configure/request_data_conditions.md)
- **Understand the plugin classes, the exact request data each reads, matching semantics, cache
  contexts, or call them from code** → [plugins/request_data_conditions.md](plugins/request_data_conditions.md)

## Two cautions worth stating whenever recommending it

1. **Never use these for access control.** Cookies, headers and query parameters are fully
   client-controlled, and session values only slightly less so. They decide what is *shown*, not what
   a user is *allowed* to see — anyone can flip a query param or cookie to change visibility. Protect
   anything sensitive with a real access check (permission / entity access), not a condition.
2. **Caching is handled, but verify it.** Each plugin contributes the matching cache context
   (`cookies:NAME`, `headers:NAME`, `url.query_args:NAME`, `session`), so a varying block is cached
   per value — test under the internal page cache (anonymous), not only while logged in.

## Key facts (real machine names)

- Condition plugins (`@Condition` annotation, dir `src/Plugin/Condition/`):
  `cookie_values` (CookieValuesCondition, reads `request->cookies->all()`),
  `http_headers` (HttpHeadersCondition, `request->headers->all()`),
  `url_query_parameters` (UrlQueryParametersCondition, `request->query->all()`),
  `session_values` (SessionValuesCondition, `request->getSession()->all()`).
- Operator constants on `BaseCondition`: `equals`, `not_equals`, `set`, `not_set`, `empty`,
  `not_empty`, `regex`, `contains`, `not_contains`.
- Config keys per instance: `conditions` (array of `{name, op, value}`) and `require_all_params`
  (bool, default `TRUE`). Injected services: `request_stack`, `current_route_match`.
- Update hook `request_data_conditions_update_8001()` rewrote stored regex values with `preg_quote`
  when the storage format changed (delimiters are added at evaluate time, not stored).
- No `.permissions.yml`, no `.routing.yml`, no `.services.yml`, no `config/`.
