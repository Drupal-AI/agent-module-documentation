# Hooks & events

## Hooks (`flag.api.php`)
| Hook | Purpose |
|---|---|
| `hook_flag_type_info_alter(array &$definitions)` | Alter registered Flag Type plugin definitions. May live in a `$module.flag.inc` file. |
| `hook_flag_link_type_info_alter(array &$link_types)` | Alter Action Link (link type) plugin definitions. |
| `hook_flag_options_alter(array &$options, FlagInterface $flag)` | Alter a flag's default options (flag type + link type options merged). |
| `hook_flag_action_access($action, FlagInterface $flag, AccountInterface $account, ?EntityInterface $flaggable)` | Grant/deny flag or unflag access; return an `AccessResult`. `$action` is `'flag'` or `'unflag'`. |

`hook_flag_action_access()` results are collected in `FlagTypeBase::actionAccess()` and
OR-combined with the default per-flag permission check, so any implementation returning
`allowed()` grants access.

## Events (`src/Event/`)
Dispatched by the flag service; subscribe via a normal event subscriber.

| Constant (`FlagEvents`) | Event class | When |
|---|---|---|
| `FlagEvents::ENTITY_FLAGGED` | `FlaggingEvent` | After an entity is flagged. |
| `FlagEvents::ENTITY_UNFLAGGED` | `UnflaggingEvent` | After an entity is unflagged. |

```php
public static function getSubscribedEvents(): array {
  return [FlagEvents::ENTITY_FLAGGED => 'onFlag'];
}
public function onFlag(FlaggingEvent $event): void {
  $flagging = $event->getFlagging();
}
```

`flag.count` (`FlagCountManager`) itself subscribes to these events to keep the
`flag_counts` table up to date.

## OO hook implementations
Flag's own hooks are implemented as service classes under `src/Hook/`
(`FlagHooks`, `FlagTokensHooks`, `FlagViewsHooks`, `FlagViewsExecutionHooks`) using the
Drupal 11 hook-attribute style, registered in `flag.services.yml`.
