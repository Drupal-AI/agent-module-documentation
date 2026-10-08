<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Like! — service API, the `like` entity, and the Views argument-default plugin

## Service `like.helper` (`LikeHelper` implements `LikeHelperInterface`)

Injected: `current_user`, `entity_type.manager`, `request_stack`, `datetime.time`,
`config.factory` (`like.services.yml`). Get it with
`\Drupal::service('like.helper')` or type-hint `Drupal\like\LikeHelperInterface`.

- **`like(EntityInterface $entity, ?AccountInterface $user = NULL)`** — creates a `like` entity
  (`entity_type`, `entity_id`, `uid` = user, `value` = 1) and saves it. For anonymous users it also
  appends the entity id to the `Drupal.visitor.like` cookie (JSON keyed by entity type;
  `setrawcookie(..., getRequestTime()+like_cookie_expiry_time, '/')`). If `cache_type == 'entity'`
  it invalidates the target entity's cache tags and resets its storage cache.
- **`unlike(EntityInterface $entity, ?AccountInterface $user = NULL)`** — for authenticated users
  deletes **all** `like` rows for (entity, current uid); for anonymous users deletes one matching
  row and removes the id from the cookie. Same cache invalidation as `like()`.
- **`userHasLiked(EntityInterface $entity, ?AccountInterface $user = NULL): bool`** —
  authenticated: entity-query COUNT of rows for (entity_type, entity_id, uid); anonymous: checks the
  `Drupal.visitor.like` cookie.
- **`getNumOfLikes(EntityInterface $entity): int`** — entity-query COUNT of all `like` rows for the
  entity (used by the computed `likes` field). All queries use the entity query builder
  (parameterised) with `accessCheck(FALSE)` on the internal count.

Typical use:

```php
$helper = \Drupal::service('like.helper');
if (!$helper->userHasLiked($node)) {
  $helper->like($node);           // records a like for the current user
}
$count = $helper->getNumOfLikes($node);
```

## The `like` content entity (`src/Entity/Like.php`)

- `@ContentEntityType(id = "like")`, base table `like`; non-fieldable, non-translatable,
  non-revisionable. `admin_permission = "administer like"`.
- Handlers come largely from the contrib **`entity`** module: access
  `UncacheableEntityAccessControlHandler`, permission provider
  `UncacheableEntityPermissionProvider`, `AdminHtmlRouteProvider`, `DeleteMultipleRouteProvider`,
  `DefaultEntityLocalTaskProvider`. Uses core `SqlContentEntityStorage`, `EntityListBuilder`,
  `EntityViewsData`.
- Base fields (`baseFieldDefinitions()` + `EntityOwnerTrait`): `id`, `uuid`, `langcode`,
  `uid` (owner), `entity_type` (string, ascii, ID_MAX_LENGTH), `entity_id` (entity_reference),
  `value` (integer, default 1), `timestamp` (default `Like::getRequestTime()`). `label()` returns
  the id.
- Links: collection `/admin/content/like`, canonical/edit/delete under `/admin/content/like/{like}`.
- **`LikeStorageSchema`** (`src/LikeStorageSchema.php`) adds a composite index
  `like__entity_type__entity_id` on (`entity_type`, `entity_id`) to the data table for fast counts.

## Views argument-default plugin `like_user_cookie` (`LikeUserOrCookie`)

`src/Plugin/views/argument_default/LikeUserOrCookie.php`,
`@ViewsArgumentDefault(id = "like_user_cookie", title = "Like: owner by user or cookie")`. On a
contextual filter it returns the ids of entities the current visitor liked, combining the
`Drupal.visitor.like` cookie and, for authenticated users, a query of `like` rows by uid — joined
with `+` (OR). Cache contexts `['user', 'cookies: Drupal_visitor_like']`, max-age PERMANENT. Use it
to build "content I liked" views.

## Event subscriber `like.ajax_refresh_like_subscriber`

`AjaxRefreshLikeSubscriber::onResponse()` (on `KernelEvents::RESPONSE`) inspects `AjaxResponse`
attachments; when the AJAX callback belongs to a `LikeForm`, it adds an `InvokeCommand` setting
`pointer-events: auto` on `.like--wrapper`, re-enabling the button after the request the JS had
temporarily disabled.

## Hooks / theme

- `like_theme()` registers the `like_form` theme hook (template `templates/like-form.html.twig`).
- `like_entity_base_field_info()` adds the computed `likes` field to enabled entity types.
- No Drush commands ship in this build (composer.json references a `drush.services.yml` that is not
  present).
