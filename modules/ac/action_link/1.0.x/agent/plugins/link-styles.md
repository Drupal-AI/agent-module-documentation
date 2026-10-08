<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Style plugins, the action route, and the access/CSRF model

The UX of an action link. Plugin type `action_link.link_style`; attribute `Attribute/ActionLinkStyle`
(id, label, description, `csrf_token_http_method`, optional `handle_state_change`, `no_ui`); manager
`ActionLinkStyleManager` (dir `Plugin/ActionLinkStyle`, alter hook `action_link_style_info`).
Interface `ActionLinkStyleInterface`, base `ActionLinkStyleBase`.

Two responsibilities: `alterLinkBuild()` adds the child render element that becomes the visible link,
and `handleActionRequest($success, …)` produces the response after the controller has (or hasn't)
advanced the state. `getCsrfTokenHttpMethod()` returns the HTTP method whose CSRF token this style
uses, or FALSE.

## Shipped styles

| id | method (CSRF) | notes |
|----|----|----|
| `ajax` | GET | JS in-place update + pop-up message; degrades to `nojs`. Adds `use-ajax` class, attaches `action_link/link_style.ajax`. |
| `nojs` | FALSE | internal fallback for `ajax` when JS is off; `no_ui`. Adds a status message, redirects to referrer. |
| `reload` | GET | plain link, reloads page, standard status message. |
| `post_link` | POST | button styled as a link (theme `post_link`); token in the form. |
| `post_link_ajax` | POST | AJAX POST button. |
| `confirm_form_page` | FALSE | link → confirmation form; `handle_state_change: TRUE` (the form's submit advances state, so the controller does not). |

`handle_state_change: TRUE` means the plugin advances the state itself; otherwise
`ActionLinkController::action()` calls `advanceState()` when the action is operable and reachable.

## The action route

Built per entity by `StateActionBase::getActionRoute()`:
`/action-link/<id>/{link_style}/{direction}/{state}/{user}/{…dynamic params}`. The route deliberately
sets **no** `_csrf_token` requirement — CSRF is handled in the controller, conditioned on the link
style, so a single route can serve both token-bearing styles and the tokenless confirm-form/nojs
paths. `{link_style}` is a path parameter so a link can be requested in a different style than the
one configured (this is what enables JS→nojs graceful degradation).

## Controller: `ActionLinkController::action()`

If the link style is `ajax`/`post_link_ajax` but the request is not an AJAX request, it is downgraded
to `nojs`. Then it reads dynamic parameters from the route match, checks operability and reachability
(these fail **silently** — the link may simply be stale, e.g. another user already changed the
state), advances the state unless the style handles it, and delegates the response to the link style
plugin.

## Controller: `ActionLinkController::access()` (the `_custom_access` callback)

1. **CSRF**: if the current user is authenticated **and** the link style declares a
   `csrf_token_http_method`, the token is read from the GET query or POST body accordingly and
   validated with `csrf_token->validate($token, $path)` against the route path with its parameters
   substituted in. A missing/invalid token → `AccessResult::forbidden()`. (Anonymous sessions carry
   no CSRF token, matching Drupal core's own CSRF access behaviour.) The matching token is minted
   when the link is built (`StateActionBase::buildLink()` → `csrf_token->get($path)`), placed in the
   GET query for GET styles or in the form for POST styles.
2. **Actor identity**: `if ($user->id() != $account->id()) return forbidden()` — the `{user}` the
   action is performed for must be the current user (proxy use is a `@todo`, not allowed).
3. **Authorization**: returns `$action_link->checkStateAccess($direction, $state, $user, …params)`,
   which requires the `use <id> action links` permission **and** operand access — for entity-field
   actions, `entity->access('update')` plus field-edit access (see `agent/plugins/state-actions.md`).

## Extending

Add a class in `Plugin/ActionLinkStyle` with `#[ActionLinkStyle(...)]`; set `csrf_token_http_method`
to `Request::METHOD_GET`/`METHOD_POST` for any style that triggers a state change from a link/button,
and implement `alterLinkBuild()` + `handleActionRequest()`. AJAX styles can reuse
`ActionLinkStyleAjaxResponseTrait`.
