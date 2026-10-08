<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_is_public` service

Class `\Drupal\entity_is_public\EntityIsPublic` implements `EntityIsPublicInterface`
(`src/EntityIsPublic.php`). Registered in `entity_is_public.services.yml` as service id
`entity_is_public` with `Drupal\entity_is_public\EntityIsPublicInterface` aliased to it (autowired).
Constructor deps: `entity_type.manager`, `entity_type.bundle.info`, `module_handler`, `current_user`.

Get it with `\Drupal::service('entity_is_public')` or inject `EntityIsPublicInterface`.

## `isApplicableType(EntityTypeInterface $entityType): bool`

Whether an entity type is *eligible* to ever be public. Returns TRUE only when the type is a
`ContentEntityTypeInterface`, is **not** `isInternal()`, has a `canonical` link template **or** a
URI callback, **and** has a view builder class (`hasViewBuilderClass()`). Otherwise FALSE. Used by
the settings form to build its checkbox list.

## `isTypePublic(string|EntityTypeInterface $entityType): bool`

Whether an entity *type* counts as public. Logic:

1. Reads the entity type's `public` property (`$entityType->get('public')`); a non-bool value is
   coerced with `filter_var(..., FILTER_VALIDATE_BOOLEAN)`.
2. If `public` was not set (NULL), it falls back to a computed default:
   `!isApplicableType($entityType) && getEntityTypeAnonymousViewAccess($entityType)`.
3. Invokes `hook_entity_type_is_public_alter($public, $entityType)` so modules can override.

The `public` property is normally seeded by this module's `entity_type_alter` hook from the
`entity_is_public.settings` config (see [config/settings.md](../config/settings.md)), so in
practice the config-driven value drives the result.

`getEntityTypeAnonymousViewAccess()` (protected) builds a throwaway entity of each bundle (or one
of no bundle) via storage `create()` and tests `$entity->access('view', new AnonymousUserSession())`,
returning TRUE if any bundle allows it. For the `user` type it seeds `uid = 1` to avoid the
core case where an anonymous session matches a NULL-id user. All wrapped in `try/catch (\Throwable)`
returning FALSE on failure.

## `isPublic(EntityInterface $entity, array $skipModules = []): bool`

Whether a specific entity instance is public. Steps (all AND-combined, short-circuiting to FALSE):

1. `isTypePublic($entity->getEntityType())`.
2. If the entity is `EntityPublishedInterface`: `&& $entity->isPublished()`.
3. `&& $entity->access('view', new AnonymousUserSession())` — the authoritative anonymous view
   access check.
4. Temporarily switches `current_user` to an anonymous session (restored afterward), then invokes
   every `hook_entity_is_public($entity)` implementation with `invokeAllWith()`; a hook returning
   FALSE flips the result to FALSE (returning TRUE/NULL cannot re-enable it). Modules listed in
   `$skipModules` are skipped — pass this to prevent recursion when calling from inside a hook.
5. Invokes `hook_entity_is_public_alter($public, $entity)` for a final override.

`$skipModules` matters: this module's own `xmlsitemap_link_alter` calls
`isPublic($entity, ['xmlsitemap'])` and `metatags_alter` calls `isPublic($entity, ['metatag'])` to
avoid re-entering their own hooks. See [api/hooks.md](hooks.md).

Each doc here is a summary — read `src/EntityIsPublic.php` for exact control flow.
