<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `_is_ajax_request` route access check

## Install / enable
`drush en ajax_requirement -y`. No configuration, no permissions, no schema. Add
`ajax_requirement:ajax_requirement` to your module's `.info.yml` `dependencies`
if you rely on the requirement.

## How it works
`ajax_requirement.services.yml` registers:

    access_check.ajax_requirement.is_ajax_request:
      class: Drupal\ajax_requirement\Access\IsAjaxRequestAccessChecker
      tags:
        - { name: access_check, applies_to: _is_ajax_request, needs_incoming_request: TRUE }

`applies_to: _is_ajax_request` binds the checker to any route that lists
`_is_ajax_request` under `requirements`. `IsAjaxRequestAccessChecker::access()`
(`src/Access/IsAjaxRequestAccessChecker.php`):

1. `$required = filter_var($route->getRequirement('_is_ajax_request'), FILTER_VALIDATE_BOOLEAN);`
   — so `'TRUE'`/`'1'`/`'true'` → true, anything else → false.
2. `$actual = $request->isXmlHttpRequest();` — Symfony `Request::isXmlHttpRequest()`,
   which is `'XMLHttpRequest' == $this->headers->get('X-Requested-With')`.
3. If `$actual !== $required` → `AccessResult::forbidden()` (403), else
   `AccessResult::allowed()`.

Note it returns `allowed()` (not `allowedIf`/neutral), so on a matching request the
checker grants access; combine with other requirements to actually gate on
permission/role — access checks are AND-combined, all must allow.

## Route usage
AJAX-only route:

    my_module.my_ajax_path:
      path: '/my-ajax-path'
      defaults:
        _title: 'Ajax path'
        _controller: '\Drupal\my_module\Controller\AjaxController::build'
      requirements:
        _permission: 'my permission'
        _is_ajax_request: 'TRUE'

Non-AJAX-only route (opposite):

    my_module.my_non_ajax_path:
      path: '/my-non-ajax-path'
      defaults:
        _title: 'Non ajax path'
        _controller: '\Drupal\my_module\Controller\AjaxController::build'
      requirements:
        _permission: 'my permission'
        _is_ajax_request: 'FALSE'

## Behaviour / testing
Verified by `tests/src/Functional/RouteTest.php` against the bundled
`tests/modules/ajax_route_test` module:
- `/my-ajax-path` → 403 with no special header, 200 with
  `X-Requested-With: XMLHttpRequest`.
- `/my-non-ajax-path` → 200 with no header, 403 with the XHR header.

## Gotchas
- The requirement value is a string in YAML; `filter_var(..., FILTER_VALIDATE_BOOLEAN)`
  means only truthy strings (`TRUE`/`true`/`1`) enable AJAX-only mode — everything
  else is treated as `FALSE` (non-AJAX-only), not "any".
- Detection relies solely on the `X-Requested-With` header, which the client sets;
  jQuery/`Drupal.ajax` send it automatically, but `fetch()` does not unless you add
  it. Treat this as a routing/UX affordance, not a trust boundary — keep
  `_permission`/`_role`/`_entity_access`/`_csrf_token` on any sensitive route.
