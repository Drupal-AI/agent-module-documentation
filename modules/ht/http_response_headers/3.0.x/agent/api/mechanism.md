<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Response Headers — how headers are applied

## The response subscriber

Service `http_response_headers` → `EventSubscriber\AddHTTPHeaders`, subscribed to
`KernelEvents::RESPONSE` at **priority `-100`** (runs late, so it can override headers other
subscribers set). Constructor args: `entity_type.manager`, `context.handler`,
`context.repository`.

`onRespond(ResponseEvent $event)`:

1. Only acts on the **main request**.
2. Loads **all** `response_header` entities (`loadMultiple()`).
3. For each entity with `status == true`:
   - If it has `visibility` conditions, evaluates them via `ConditionAccessResolverTrait`
     with **AND** logic; a missing context or missing value ⇒ the header is **not** applied
     for this response.
   - If checks pass, looks at `value`:
     - **non-empty value** → set/replace the header `name` = `value`.
     - **empty value** → if the response currently has that header, **remove it**.

Header names are matched case-preservingly against
`$response->headers->allPreserveCaseWithoutCookies()`.

## Consequences for agents

- To **add/replace** a header: enabled entity, `name` + non-empty `value`.
- To **strip** a header (e.g. `X-Powered-By`, `X-Generator`): enabled entity, matching
  `name`, **empty `value`**. (This is how the shipped `x_powered_by` / `x_generator`
  defaults hide those headers.)
- Because it runs at priority `-100`, it wins over most other header-setting code for the
  same header name.
- Disabled entities (`status == false`) are ignored entirely.
- `visibility` uses core condition plugins — the module defines **no plugin types of its
  own**. Empty `visibility` means the header always applies.

## Related hooks

`HttpResponseHeadersHooks` implements `hook_help`, and cleans up `visibility` conditions
when a user role or configurable language they reference is deleted
(`hook_user_role_delete`, `hook_configurable_language_delete`). No Drush commands.
