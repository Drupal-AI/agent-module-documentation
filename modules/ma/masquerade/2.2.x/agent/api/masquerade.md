# Switch users in code

Service `masquerade` (`Drupal\masquerade\Masquerade`; also autowirable by class name).

```php
/** @var \Drupal\masquerade\Masquerade $m */
$m = \Drupal::service('masquerade');

$target = \Drupal::entityTypeManager()->getStorage('user')->load($uid);
$m->switchTo($target);       // become $target; returns TRUE on success
$m->isMasquerading();        // bool — currently impersonating?
$m->switchBack();            // return to the original user; FALSE if not masquerading
$m->getPermissions();        // string[] of this module's permission names
```

- `switchTo($target_account)` stores the current uid in the session metadata bag, regenerates
  the session ID (session-fixation guard), swaps `current_user` + session `uid`, and invokes
  `user_logout` (old) then `user_login` (new) hooks. Logs the impersonation.
- `switchBack()` loads the stored previous uid, switches back, clears the masquerade flag, and
  logs it; returns FALSE if not masquerading or the original account is gone.
- Access should still be checked first — the routes use `_masquerade_switch_access` /
  `_user_is_masquerading`; validate a target with `masquerade_switch_user_validate()`.
- Cache context `session.is_masquerading` (`MasqueradeCacheContext`) lets render output vary
  by masquerading state. Session state is held in `Session\MetadataBag`.
