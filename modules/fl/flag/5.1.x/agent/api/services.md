# Services

Declared in `flag.services.yml`. All autowired; interfaces are aliased so you can
type-hint them for injection.

## `flag` — `Drupal\flag\FlagService` (`FlagServiceInterface`)
Core API for reading and mutating flaggings.

```php
$flagService = \Drupal::service('flag');
$flag = $flagService->getFlagById('bookmark');
if (!$flag->isFlagged($node)) {
  $flagService->flag($flag, $node);      // flag for current user (or $account/$session_id)
}
$flagService->unflag($flag, $node);
```
Notable methods: `getAllFlags($entity_type, $bundle)`, `getFlagById($id)`,
`getFlaggableById($flag, $entity_id)`, `getFlagging($flag, $entity, $account, $session_id)`,
`getEntityFlaggings()`, `getAllEntityFlaggings()`, `getFlaggingUsers($entity, $flag)`,
`getAllFlaggingByUser($account, $session_id)`, `getFlagUserFlaggings()`,
`getFlagFlaggings()`, `flag()` / `unflag()`, `unflagAllByFlag()`, `unflagAllByEntity()`,
`unflagAllByUser()`, `unflagAllByFlagByUser()`, `populateFlaggerDefaults()`,
`getAnonymousSessionId()` / `ensureSession()` (anonymous flags are session-keyed).

`flag()`/`unflag()` throw `\LogicException` when the flag does not apply to the entity
type/bundle, or when already-flagged / not-flagged. Route controllers catch this and fail
silently, returning the refreshed link.

## `flag.count` — `Drupal\flag\FlagCountManager` (`FlagCountManagerInterface`)
Counting; also an event subscriber that maintains the `flag_counts` table on flag/unflag.
`getEntityFlagCounts($entity)`, `getFlagFlaggingCount($flag)`,
`getFlagEntityCount($flag)`, `getUserFlagFlaggingCount($flag, $user, $session_id)`.

## `flag.link_builder` — `Drupal\flag\FlagLinkBuilder` (`FlagLinkBuilderInterface`)
Lazy-builder (`TrustedCallbackInterface`) that returns a render-array flag/unflag link for
an entity: `build($entity_type_id, $entity_id, $flag_id, $view_mode = 'default')`. Used by
the flag field / extra field and the `flaglink()` Twig function.

## Twig extensions
- `flag.twig.count` — `FlagCount`: registers the `flagcount()` Twig function.
- `flag.twig.link` — `FlagLink`: registers the `flaglink()` Twig function.

See [theming/theming.md](../theming/theming.md).

## Plugin managers
`plugin.manager.flag.flagtype` (FlagType) and `plugin.manager.flag.linktype`
(ActionLink) — see [plugins/plugins.md](../plugins/plugins.md).
