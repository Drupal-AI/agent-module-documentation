Ajax requirement is a tiny API module that adds an `_is_ajax_request` route access check so a route can be allowed only for AJAX (XMLHttpRequest) requests, or only for non-AJAX requests.

---

Ajax requirement ships one service, an access checker (`Drupal\ajax_requirement\Access\IsAjaxRequestAccessChecker`) tagged `access_check` with `applies_to: _is_ajax_request`. When a route declares `_is_ajax_request: 'TRUE'` in its `requirements`, the checker allows access only when the incoming request is an XMLHttpRequest (Symfony's `Request::isXmlHttpRequest()`, i.e. header `X-Requested-With: XMLHttpRequest`); with `'FALSE'` it allows access only for non-AJAX requests. It is a routing/UX utility, not a security boundary — the `X-Requested-With` header is client-supplied, so you still combine it with real requirements such as `_permission`, `_role`, `_entity_access` or `_csrf_token`. There is no UI, no configuration, no permissions, no schema, and no database footprint; you enable the module and use the requirement in your own module's `*.routing.yml`. Requires Drupal 8.8+ through 11 and no other modules.

---

- Restrict a callback route so it serves content only when requested via AJAX: add `_is_ajax_request: 'TRUE'` to the route's `requirements`.
- Serve a full-page version of the same controller for non-AJAX visits by declaring a second route with `_is_ajax_request: 'FALSE'`.
- Return a lightweight partial/render array for in-page AJAX loads while returning a full page shell for direct browser navigation.
- Guard an autocomplete or typeahead endpoint so it is reachable only from the on-page JavaScript that issues XHR requests.
- Back a dependent-dropdown / dynamic form-options endpoint that should only respond to AJAX calls.
- Provide a "load more" / infinite-scroll endpoint that answers only AJAX requests.
- Split a modal dialog route (AJAX) from its standalone fallback page (non-AJAX) using two routes on the same controller.
- Hide an internal fragment/preview endpoint from direct browser URLs (returns 403 when opened directly, 200 when fetched via XHR).
- Return 403 for search-suggestion endpoints when accessed outside the intended AJAX widget.
- Combine `_is_ajax_request: 'TRUE'` with `_permission` so a route needs both the permission and an AJAX context.
- Combine it with `_csrf_token: 'TRUE'` for AJAX POST-style endpoints that also need CSRF protection.
- Give crawlers/bots a non-AJAX page while the interactive experience uses the AJAX route.
- Serve BigPipe/placeholder-style deferred content through an AJAX-only route.
- Provide a JSON/HTML fragment for a JavaScript component library that must not be linkable directly.
- Redirect or 403 direct hits to a route intended purely as an XHR target.
- Build a wizard step endpoint that only responds when the wizard's JS drives it via AJAX.
- Use it as a dependency in your own contrib/custom module so route definitions stay declarative (`ajax_requirement:ajax_requirement`).
- Write functional tests that assert a route returns 200 with the `X-Requested-With: XMLHttpRequest` header and 403 without it (see the module's `RouteTest`).
- Keep AJAX-only and full-page logic in one controller method while differentiating access purely at the routing layer.
