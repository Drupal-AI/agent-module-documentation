<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The token-tree route swap and category filter

How Categorized Token Filter overrides Drupal Token's token browser. Read this instead of the
three source files.

## Install / enable

`composer require drupal/categorized_token_filter` then `drush en categorized_token_filter`.
Requires contrib **Token** (`^1.6`), which is a hard dependency. No configuration, no permissions,
no settings route — enabling is the entire setup. Uninstalling restores core Token's controller.

## Route override (RouteSubscriber)

`src/Routing/RouteSubscriber.php` — service `categorized_token_filter.route_subscriber`
(`categorized_token_filter.services.yml`, tag `event_subscriber`, extends `RouteSubscriberBase`).

```
alterRoutes(RouteCollection $collection):
  if $route = $collection->get('token.tree'):
    $route->setDefault('_controller',
      'Drupal\categorized_token_filter\Controller\CategorizedTokenTreeController::outputTree');
```

Only the `_controller` default is replaced. The core `token.tree` route
(`/token/tree`, requirement `_csrf_token: 'TRUE'`) keeps its path and access requirement, so the
browser is still reached through Token's own CSRF-checked AJAX callback — this module adds no new
route and no new access surface.

## Controller (CategorizedTokenTreeController)

`src/Controller/CategorizedTokenTreeController.php` extends core
`Drupal\token\Controller\TokenTreeController` (inherits `$treeBuilder`, `formBuilder()`, `t()`).

`outputTree(Request $request)`:
1. `$options = $request->query->has('options') ? Json::decode($request->query->get('options')) : [];`
2. `$token_types = !empty($options['token_types']) ? $options['token_types'] : [];`
3. If `$token_types == 'all'` → render the category picker: `$this->formBuilder()->getForm(TokensModalForm::class)`.
4. Otherwise → parent behavior: `$this->treeBuilder->buildRenderable($token_types, $options)`; and
   for XHR requests add `#prefix`/`#suffix` `<div>`, cache context `url.query_args:options`, and a
   "Available tokens" title (so Token's `tokenTree`/`tokenAttach` JS behaviors still bind).

The tree builder renders token **definitions** (type/name/description from `token_getInfo()`),
not resolved token values. Loose `==` against the literal string `'all'` is a simple mode switch,
not an auth check.

## Category picker (TokensModalForm)

`src/Form/TokensModalForm.php` — `FormBase`, id `tokens_modal_form`. Constructor injects
`EntityTypeManagerInterface`, `token.tree_builder` (`TreeBuilderInterface`), and the `token` service.

- `buildForm()` attaches library `categorized_token_filter/tokens_modal_form` and builds a
  container `#tokens_modal` with a **multi-select** (`filter`, `#options` from `getOptions()`,
  `chosen-enable` class, autofocus) and a **Select** button whose `#ajax` callback is
  `selectCallback` (wrapper `tokens_modal`, fullscreen progress). `submitForm()` is empty — this
  form only drives AJAX, it never persists anything.
- `getOptions()` iterates `entityTypeManager->getDefinitions()`, keeps content-entity types that
  declare a `token_type`, maps `token_type => entity label` (`->render()`), `asort()`s them, and
  returns `['global_types' => 'Global types'] + $token_types + ['others' => 'Others']`. Cached in
  `$this->options`.
- `selectCallback()` sets `select_list['build'] = getBuild($form_state->getValues())` and returns
  an `AjaxResponse` with a `ReplaceCommand('#tokens_modal', …)`.
- `getBuild($values)`: `$filters = array_filter($values['filter'])`; `$info = $token->getInfo()`.
  Assembles the token types to show via three helpers, then
  `treeBuilder->buildRenderable($token_types, $options)` wrapped in `<div>…</div>` with cache
  context `url.query_args:options`:
  - `getGlobalTypes($filters)` → returns `[]` if `global_types` selected, else
    `['global_types' => FALSE]` to suppress global tokens.
  - `getEntityTypes($info, $filters, &$token_types)` → adds each `$info['types']` key whose
    prefix (`explode('-', $type)[0]`) is in the selected filters.
  - `getOtherTypes($info, $filters, &$token_types)` → when `others` is selected, adds every token
    type whose prefix is **not** one of the known option keys.

## Assets

`categorized_token_filter.libraries.yml` defines `tokens_modal_form` = `css/tokens-modal-form.css`
(flexbox layout for the select + button row). No module JS; token insertion reuses Token's JS.

## Operating notes

- Nothing to configure. The categorized browser is active wherever core Token's `token.tree`
  callback is invoked (e.g. "Browse available tokens" links).
- Behavior differs from stock Token only in `'all'` mode, where the category picker appears; a
  specific `token_types` array request behaves exactly like core Token.
- If contrib Token is absent the module cannot be enabled (hard dependency); if the `token.tree`
  route is missing the subscriber is a no-op.
