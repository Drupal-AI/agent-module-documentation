# Extend session enforcement — events & service API

Session Limit dispatches three Symfony events (by string name) that you can subscribe to in a
custom module to alter enforcement. The core enforcement lives in the `session_limit` service
(`Drupal\session_limit\Services\SessionLimit`), itself an `EventSubscriberInterface` running on
`KernelEvents::REQUEST` at priority 32.

## Events

| Event name | Event class | Purpose |
|---|---|---|
| `session_limit.bypass` | `SessionLimitBypassEvent` | Decide whether to skip the session-limit check for this request. |
| `session_limit.collision` | `SessionLimitCollisionEvent` | Fired when a user's active sessions exceed their max. |
| `session_limit.disconnect` | `SessionLimitDisconnectEvent` | Fired just before a session is ended; can be prevented or given a custom message. |

### `SessionLimitBypassEvent`
- `setBypass(TRUE)` — request the check be skipped. If any listener sets TRUE, the check is
  bypassed (it never flips back to FALSE). `shouldBypass()` reads the state.
- The module's own listener already bypasses User 1 (unless `session_limit_admin_inclusion`),
  anonymous, masqueraded sessions, already-verified sessions, and the `/session-limit` and
  `/user/logout` paths.

### `SessionLimitCollisionEvent`
Constructed with `($sessionId, AccountInterface $account, $userActiveSessions, $userMaxSessions)`.
Getters: `getSessionId()`, `getAccount()`, `getUserActiveSessions()`, `getUserMaxSessions()`.
Read-only — use it to react (log, notify) to a limit being hit.

### `SessionLimitDisconnectEvent`
Constructed with `($sessionId, SessionLimitCollisionEvent $collisionEvent, $message)`.
- `preventDisconnect(TRUE)` — stop this session being ended (any listener setting TRUE wins).
- `shouldPreventDisconnect()` — read that state.
- `getMessage()` / `setMessage($message)` — customise the logout message for this disconnect.
- `getCollisionEvent()` — the originating collision.

## Example subscriber

```php
namespace Drupal\mymodule\EventSubscriber;

use Drupal\session_limit\Event\SessionLimitBypassEvent;
use Drupal\session_limit\Event\SessionLimitDisconnectEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySessionLimitSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [
      'session_limit.bypass' => ['onBypass'],
      'session_limit.disconnect' => ['onDisconnect'],
    ];
  }

  public function onBypass(SessionLimitBypassEvent $event): void {
    // Never limit requests to an API path, for example.
    // $event->setBypass(TRUE);
  }

  public function onDisconnect(SessionLimitDisconnectEvent $event): void {
    $event->setMessage('Your other session was ended by policy.');
    // Or keep a session alive: $event->preventDisconnect(TRUE);
  }
}
```

Register it in `mymodule.services.yml` with the `event_subscriber` tag.

## Service API (`session_limit`)

Useful public methods on `Drupal\session_limit\Services\SessionLimit`:

| Method | Returns |
|---|---|
| `getUserActiveSessionCount(AccountInterface $account)` | int count of the user's active sessions (DISTINCT `sid`). |
| `getUserActiveSessions(AccountInterface $account)` | array of session rows (uid, sid, hostname, timestamp). |
| `getUserMaxSessions(AccountInterface $account)` | int effective max (`< 1` = unlimited). |
| `getCollisionBehaviour()` | the configured `session_limit_behaviour` value. |
| `sessionDisconnect($sid, $message)` | mark a session anonymous with a stored message. |
| `disconnectActiveSession($message)` | destroy the current session and drop to anonymous. |
| `SessionLimit::getActions()` (static) | the behaviour id → label map. |

Constants: `ACTION_ASK = 0`, `ACTION_DROP_OLDEST = 1`, `ACTION_PREVENT_NEW = 2`,
`USER_UNLIMITED_SESSIONS = -1`.
