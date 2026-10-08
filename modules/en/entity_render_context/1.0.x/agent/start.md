<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Render Context — agent index

One service that renders entities under a controlled theme / user / language / view mode context and
restores the original context afterwards. No UI, routes, permissions, config, or plugins. Optional core
`language` dependency enables language switching.

- **The `entity_render_context.renderer` service: `renderEntity`, `renderEntities`, `clearCache`,
  cache-key format, error handling** → [api/renderer.md](api/renderer.md)

Key facts:
- Service id `entity_render_context.renderer`, interface `Drupal\entity_render_context\EntityRenderContextInterface`.
- `renderEntity(EntityInterface $entity, ?string $viewMode='full', ?string $theme=NULL, ?AccountInterface $account=NULL, ?string $langcode=NULL): ?string`
- Defaults: full view mode, current theme, **anonymous** user, entity language.
- Returns `NULL` on render error (logged); always restores context via `finally`.
