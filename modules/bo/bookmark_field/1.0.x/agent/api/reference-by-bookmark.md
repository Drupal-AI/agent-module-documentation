<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Resolving entities by bookmark — service, route, block, Twig, Views, token

All resolution goes through the `bookmark_service` service; each surface (route, block, Twig, Views,
token) is a thin wrapper over it.

## Service — `BookmarkService` (`bookmark_service`)
`src/BookmarkService.php`, implements `BookmarkServiceInterface`. Injects `entity_type.manager` and
`entity.repository` (see `bookmark_field.services.yml`).

- **`loadEntityByBookmark($entity_type, $bookmark, $field_name = 'field_bookmark')`**
  → `getStorage($entity_type)->loadByProperties([$field_name => $bookmark])`, returns `current()`
  (the **first** match). Uses the entity query API — no raw SQL. Does **not** filter by published
  status or access; it is a bare lookup. Bookmark uniqueness is not enforced.
- **`renderEntityByBookmark($entity_type, $bookmark, $field_name='field_bookmark',
  $view_mode='full')`** → loads via the above, applies
  `entity.repository->getTranslationFromContext()`, then **returns `[]` unless** the entity is an
  `EntityPublishedInterface` **and** `isPublished()`, **and** `access('view')` is TRUE. Only then
  does it build with `getViewBuilder()->view($entity, $view_mode)`. This is the access-aware render
  path used by the block, the Twig function and `bookmark_field_render()`.

## Redirect route — `bookmark_field.redirect`
`bookmark_field.routing.yml`: path `/bookmark/redirect/{entity_type}/{bookmark}`,
`_permission: 'access content'`, controller `BookmarkController::forward()`
(`src/Controller/BookmarkController.php`, injects `bookmark_service` + `request_stack`).

`forward($entity_type, $bookmark)`:
1. `$entity = loadEntityByBookmark($entity_type, $bookmark)` (default field `field_bookmark`).
2. If found → `return $this->redirect('entity.' . $entity_type . '.canonical',
   [$entity_type => $entity->id()], ['query' => <all current query params>])` — a 302 to the
   entity's canonical route, forwarding the incoming query string.
3. If not found → `throw new NotFoundHttpException()` (404).

The redirect target is an **internal named route** built from `$entity_type` (no user-supplied
destination URL), and the canonical route enforces its own access when the browser follows the 302.

## Block — `bookmark_block`
`src/Plugin/Block/BookmarkBlock.php`, admin label "Bookmark block", injects `bookmark_service`.
`blockForm()` collects `entity_type` (default `node`), `field_name` (default `field_bookmark`),
`view_mode` (default `full`), `bookmark` (required). `build()` calls
`renderEntityByBookmark(...)`; returns `['#markup' => '']` when the result is empty (so unpublished/
inaccessible/missing targets render nothing). Config schema: `block.settings.bookmark_block`.

## Twig function — `bookmarkFieldRender()`
`src/TwigExtension/BookmarkExtension.php` (service `bookmark_service.twig.render`, tagged
`twig.extension`). `{{ bookmarkFieldRender('node', 'my_bookmark', 'field_bookmark', 'full') }}`
calls `renderEntityByBookmark()` — same published + `view` access checks apply.

## Procedural render helper
`bookmark_field_render($entity_type, $bookmark, $field_name='field_bookmark', $view_mode='full')` in
`bookmark_field.module` is a thin wrapper over the service's `renderEntityByBookmark()`.

## Views argument defaults
`src/Plugin/views/argument_default/`.
- **`Bookmark`** (id `bookmark_field`, title "Bookmark"): options `bookmark_field_name`, `bookmark`,
  `target_type`. `getArgument()` = `loadEntityByBookmark(target_type, bookmark, bookmark_field_name)`
  → entity id (or NULL). Its `access()` returns TRUE (this only governs whether the argument-default
  plugin is offered; the View's own filters/access still apply to results).
- **`BookmarkFromUrl`** (id `bookmark_field_from_url`, title "Bookmark from URL", extends
  `Bookmark`): drops the static `bookmark`, adds `index` (which 1-based path component to use) and
  `use_alias` (bool). `getBookmark()` takes the current request path (optionally the path alias via
  `path_alias.manager`), `explode('/')`, and returns the component at `index`. Injects
  `path_alias.manager` + `path.current`.

## Token — `[bookmark:<name>]`
`bookmark_field_token_info()` defines token group `bookmark` and token `bookmark_field_url`
(example `[bookmark:recipes_home]`). `bookmark_field_tokens()` resolves each token name as a **node**
bookmark: `loadEntityByBookmark('node', $name)`, then the node's `getTranslationFromContext()->
toUrl()->toString()`, else ''. Node-only (per the in-code `@todo`); it returns the node's canonical
URL string (the path, which core access-checks when actually visited).
