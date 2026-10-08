<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend: auditor services and events

Audit Files has **no plugin type and no hooks**. You extend it two ways: call the auditor
services, or subscribe to the events its fix operations dispatch.

## Auditor services (one per report)

Each report's comparison logic is an autowired service you can inject (`Drupal\auditfiles\Auditor\*`):

| Service id | Class | Report |
|---|---|---|
| `auditfiles.auditor.not_in_database` | `AuditFilesNotInDatabase` | Not in database |
| `auditfiles.auditor.not_on_server` | `AuditFilesNotOnServer` | Not on server |
| `auditfiles.auditor.managed_not_used` | `AuditFilesManagedNotUsed` | Managed not used |
| `auditfiles.auditor.used_not_managed` | `AuditFilesUsedNotManaged` | Used not managed |
| `auditfiles.auditor.used_not_referenced` | `AuditFilesUsedNotReferenced` | Used not referenced |
| `auditfiles.auditor.referenced_not_used` | `AuditFilesReferencedNotUsed` | Referenced not used |
| `auditfiles.auditor.merge_file_references` | `AuditFilesMergeFileReferences` | Merge file references |

Two config helpers: `auditfiles.config` (`AuditFilesConfigInterface`, typed settings getters)
and `auditfiles.exclusions` (`AuditFilesExclusions`, applies the exclude-files/extensions/paths
rules). Services are declared with `autoconfigure: true` / `autowire: true`, so you can typehint
the class in your own service and Drupal injects it.

## Events

The fix actions dispatch Symfony events (in `src/Event/`); the module's own
`Drupal\auditfiles\AuditFilesListener` is the default subscriber that performs the DB/disk write.
**The event name is the class name** (`getSubscribedEvents()` keys on `SomeEvent::class`), so a
custom subscriber uses the FQCN as the event id:

| Event class | Dispatched when |
|---|---|
| `AuditFilesAddFileOnDiskEvent` | An on-disk file is being added to `file_managed` (listener creates/saves the File entity). |
| `AuditFilesAddUsageForFileFieldReferenceEvent` | A missing `file_usage` row is added for a discovered reference. |
| `AuditFilesDeleteFileEntityEvent` | A `file_managed` File entity is being deleted. |
| `AuditFilesDeleteFileOnDiskEvent` | A physical file is being deleted from disk. |
| `AuditFilesDeleteFileUsageEvent` | A `file_usage` row is being deleted. |
| `AuditFilesDeleteFileFieldReferenceEvent` | A file-field reference on an entity is being removed. |
| `AuditFilesMergeFilesEvent` | Duplicate `file_managed` records are being merged into one. |

Subscribe to any of these to add side effects (logging, notifications, custom cleanup) around a
repair, or to veto/augment it:

```php
use Drupal\auditfiles\Event\AuditFilesDeleteFileOnDiskEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyAuditSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [AuditFilesDeleteFileOnDiskEvent::class => ['onDeleteOnDisk']];
  }
  public function onDeleteOnDisk(AuditFilesDeleteFileOnDiskEvent $event): void {
    // Inspect the event and react before/after the file is removed.
  }
}
```

Register it as a tagged `event_subscriber` service. Because the module's `AuditFilesListener`
already handles each event, order your subscriber with a priority relative to it if you need to
run before or after the actual write.
