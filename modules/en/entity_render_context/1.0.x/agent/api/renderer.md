<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the render service

Service: `entity_render_context.renderer` (class `EntityRenderContext`, interface
`EntityRenderContextInterface`). Inject it or `\Drupal::service('entity_render_context.renderer')`.

## `renderEntity()`
```php
public function renderEntity(
  EntityInterface $entity,
  ?string $viewMode = 'full',
  ?string $theme = NULL,      // default: current theme
  ?AccountInterface $account = NULL,  // default: anonymous user
  ?string $langcode = NULL,   // default: entity language
): ?string
```
Returns the rendered HTML string, or `NULL` on error (caught + logged). Throws `\RuntimeException`
only if a supplied account cannot be loaded. Context (theme, active user, language) is switched for the
render and **always restored**, including on exceptions (`finally`).

```php
$svc = \Drupal::service('entity_render_context.renderer');
$html = $svc->renderEntity($node);                         // full, current theme, anonymous, entity lang
$teaser = $svc->renderEntity($node, 'teaser');
$de = $svc->renderEntity($node, 'full', NULL, NULL, 'de'); // German (needs language module)
$asUser = $svc->renderEntity($node, 'full', NULL, User::load(1));
$inTheme = $svc->renderEntity($node, 'full', 'olivero');
```

## `renderEntities()`
```php
public function renderEntities(array $entities, ?string $viewMode='full', ?string $theme=NULL,
  ?AccountInterface $account=NULL, ?string $langcode=NULL): array
```
Calls `renderEntity()` per item (each gets its own full context switch). Returns an array in input order;
failed/invalid entries are `NULL`.

## `clearCache()`
```php
public function clearCache(?string $cacheKey = NULL): void   // NULL clears all
```
Request-scoped static cache only (not persistent). Cache key format:
`{entity_type}:{entity_id}:{revision_id}:{view_mode}:{langcode}:{theme}:{account_id}`
(revision_id is `null` for non-revisionable entities; anonymous account_id is `0`). The cache is
checked *before* any context switching, so hits are cheap. Call `clearCache()` after large bulk runs.

## Notes
- Language switching only works when core `language` is enabled (service wired as `@?...` optional).
- Rendering uses `renderInIsolation()` (D10.3+) via `DeprecationHelper::backwardsCompatibleCall()`,
  falling back to `renderPlain()` on older cores.
- After theme switching the service resets the `template_preprocess` static cache so theme variables
  are correct.
- Supporting services (not usually called directly): `entity_render_context.theme_switcher`
  (`ThemeSwitcherInterface`), `entity_render_context.language_negotiator_switcher`,
  `entity_render_context.static_language_negotiator`.
