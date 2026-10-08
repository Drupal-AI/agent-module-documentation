# Download enforcement & access-alter event

The real protection lives in `protected_file_file_download($uri)` (an implementation of core
`hook_file_download()` in `protected_file.module`). Core only calls this for `private://` files served
through `/system/files/...`, which is why the field is locked to the private scheme.

## Enforcement flow

1. Load the file entity by uri; abstain (`return;`) if none.
2. Get field references via `file_get_file_references($file, NULL, FIELD_LOAD_CURRENT, 'protected_file')`.
   If there are no `protected_file` references and the file is permanent (or not owned by the current
   user), abstain so other modules control it.
3. Start from allow: `$headers = file_get_content_headers($file)`.
4. For each referencing entity field value, if `target_id` matches and `protected_file == 1`:
   - If the current user **lacks** `download protected file` → set `$headers = -1` (deny).
   - Dispatch `ProtectedFileAccessEvent` (see below) so modules can override, then translate the
     event's access result back to headers/`-1`.
5. Return `$headers` (array = allow with headers, `-1` = deny). Returning `-1` from any
   `hook_file_download` implementation makes core deny the download — so the gate cannot be bypassed by
   guessing the direct file URL.

`ProtectedFileAccessChecker` (`protected_file.access_checker` service) just maps between the
`hook_file_download` return convention and `AccessResultInterface`:
`getAccessResultFromHeaders(-1) => AccessResultForbidden`, else `AccessResultAllowed`;
`getHeadersFromAccessResult()` does the reverse.

## Alter access with the event

Subscribe to `ProtectedFileEvents::CHECK_ACCESS` (`'protected_file.check_access'`). The event carries the
current `AccessResultInterface`, the `$uri`, the `FileInterface`, and the host `FieldableEntityInterface`
(may be null). Call `setAccessResult()` to allow/deny per your own rules (ownership, purchase, group
membership, etc.).

```php
// src/EventSubscriber/MyProtectedFileSubscriber.php
use Drupal\protected_file\Event\ProtectedFileAccessEvent;
use Drupal\protected_file\Event\ProtectedFileEvents;
use Drupal\Core\Access\AccessResult;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyProtectedFileSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [ProtectedFileEvents::CHECK_ACCESS => 'onCheckAccess'];
  }
  public function onCheckAccess(ProtectedFileAccessEvent $event): void {
    $entity = $event->getEntity();
    // e.g. allow the file's owner regardless of permission:
    if ($entity && $entity->getEntityTypeId() === 'node' && $entity->getOwnerId() == \Drupal::currentUser()->id()) {
      $event->setAccessResult(AccessResult::allowed());
    }
  }
}
```

Register it as a tagged `event_subscriber` service in your module's `*.services.yml`.

## Permission

`download protected file` (defined in `protected_file.permissions.yml`, no `restrict access`) is the
permission the gate checks. Grant it to whichever roles should be able to download protected files;
users without it are redirected (display side) and denied (download side).
