# Hooks & events

## Hooks (`flag.api.php`)
| Hook | Purpose |
|---|---|
| `hook_flag_type_info_alter(array &$definitions)` | Alter registered Flag Type plugin definitions. |
| `hook_flag_link_type_info_alter(array &$link_types)` | Alter Action Link (link type) plugin definitions. |
| `hook_flag_options_alter(array &$options, FlagInterface $flag)` | Alter a flag's link/options build. |
| `hook_flag_action_access($action, FlagInterface $flag, AccountInterface $account, ?EntityInterface $flaggable)` | Grant/deny flag or unflag access; return an `AccessResult`. `$action` is `'flag'` or `'unflag'`. |

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
