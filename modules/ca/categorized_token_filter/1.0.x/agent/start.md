<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Categorized Token Filter (categorized_token_filter) — agent index

Extends contrib **Token**. It does **not** provide a text-format filter, a field formatter, an
entity, permissions, config, or a settings route. Its whole job: swap the controller behind
Token's existing `/token/tree` browser route so the token tree can be **filtered by category**
before it is built — faster than rendering every token on entity-heavy sites.

- Depends on `drupal:token` (`^1.6`). Core `^10 || ^11`, PHP `>=8.0`. License GPL-2.0-or-later.
  Version 1.0.x (packaged 1.0.2).
- **How the route swap, the controller, and the modal filter form work** →
  [api/token-tree.md](api/token-tree.md)

## What it actually is (from source)

- **Route subscriber** `RouteSubscriber` (`src/Routing/RouteSubscriber.php`, service
  `categorized_token_filter.route_subscriber`, tag `event_subscriber`). In `alterRoutes()` it
  finds core Token's `token.tree` route and rewrites its `_controller` default to
  `CategorizedTokenTreeController::outputTree`. It changes **only the controller** — path,
  `_csrf_token: 'TRUE'` requirement and everything else stay as core Token defined them.
- **Controller** `CategorizedTokenTreeController` (`src/Controller/`) **extends** core
  `Drupal\token\Controller\TokenTreeController`. `outputTree(Request)` JSON-decodes the `options`
  query arg (same as parent). If `options['token_types'] === 'all'` it returns the modal filter
  form via `formBuilder()->getForm(TokensModalForm::class)`; otherwise it falls back to the
  parent behavior (`treeBuilder->buildRenderable($token_types, $options)` with the AJAX wrapping
  div/cache-context).
- **Form** `TokensModalForm` (`src/Form/`, id `tokens_modal_form`, extends `FormBase`) — the
  category picker plus AJAX tree build. Injects `entity_type.manager`, `token.tree_builder`,
  `token`.
- **Assets:** internal library `categorized_token_filter/tokens_modal_form`
  (`css/tokens-modal-form.css` only) attached by the form. No JS of its own; token-insert JS is
  inherited from Token.

## No config surface

No `*.routing.yml`, `*.permissions.yml`, `*.install`, `*.module`, `config/install`, or
`config/schema`. `configure` is null. Enable it and the categorized browser is live; uninstall
reverts to core Token's controller.
