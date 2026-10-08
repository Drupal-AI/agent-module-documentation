<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax requirement (ajax_requirement) — agent index

API module (no UI, no config, no permissions, no DB). Adds a single route access
check, `_is_ajax_request`, so a route can be limited to AJAX (XMLHttpRequest)
requests or to non-AJAX requests. Core `^8.8 || ^9 || ^10 || ^11`; no module deps.

## What it provides
- Service `access_check.ajax_requirement.is_ajax_request` (in
  `ajax_requirement.services.yml`), tagged `access_check` with
  `applies_to: _is_ajax_request`, `needs_incoming_request: TRUE`.
- Access checker class `Drupal\ajax_requirement\Access\IsAjaxRequestAccessChecker`
  (`src/Access/IsAjaxRequestAccessChecker.php`) — its `access(Route, Request)`
  compares `filter_var($route->getRequirement('_is_ajax_request'), FILTER_VALIDATE_BOOLEAN)`
  against `$request->isXmlHttpRequest()` and returns
  `AccessResult::allowed()`/`forbidden()`.
- No entities, plugins, controllers, routes, permissions, hooks, config, or schema
  of its own. You consume the requirement from your own module's `*.routing.yml`.

## Docs
- Route usage & the access check: [agent/api/access-check.md](api/access-check.md)

## Notes
- Requirement value is a Drupal route requirement string: `'TRUE'` = AJAX-only,
  `'FALSE'` = non-AJAX-only.
- Not an authentication/authorization boundary on its own — `X-Requested-With` is
  client-supplied. Always pair with real requirements (`_permission`, `_role`,
  `_entity_access`, `_csrf_token`).
