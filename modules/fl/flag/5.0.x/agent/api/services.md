# Services

Declared in `flag.services.yml`.

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
`getFlagging($flag, $entity, $account)`, `getEntityFlaggings()`,
`getFlaggingUsers($entity, $flag)`, `getAllFlaggingByUser($account)`,
`flag()` / `unflag()`, `unflagAllByFlag()`, `unflagAllByEntity()`,
`unflagAllByUser()`, `populateFlaggerDefaults()`.

## `flag.count` — `Drupal\flag\FlagCountManager` (`FlagCountManagerInterface`)
Counting (also an event subscriber that maintains counts):
`getEntityFlagCounts($entity)`, `getFlagFlaggingCount($flag)`,
`getFlagEntityCount($flag)`, `getUserFlagFlaggingCount($flag, $user)`.

## `flag.link_builder` — `Drupal\flag\FlagLinkBuilder`
Builds render-array flag/unflag links for an entity (used by the field/extra-field).

## `flag.twig.count` — `FlagCount` Twig extension
Registers the `flag_count()` Twig function (see theming doc).
