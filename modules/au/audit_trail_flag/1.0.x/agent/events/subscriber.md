<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flag event subscriber & audit logging

The whole module is one hook plus one event subscriber. There is no UI, config object, route, or
permission — it wires itself up on enable and writes to the shared Admin Audit Trail log.

## Install / enable

Requires `admin_audit_trail` and `flag` to be present (hard deps). Enable with
`drush en audit_trail_flag -y` (or the UI), then clear cache. No configuration follows.

## Handler registration

`audit_trail_flag.module` implements `hook_admin_audit_trail_handlers()` and returns one handler:

```php
$handlers['flag'] = ['title' => t('Flag')];
```

This declares the `flag` log type to Admin Audit Trail so its report can filter to flag events.

## Services (`audit_trail_flag.services.yml`)

- `audit_trail_flag.flag_subscriber` — `Drupal\audit_trail_flag\EventSubscriber\AuditTrailFlagSubscriber`,
  tag `event_subscriber`, arg `@logger.channel.audit_trail_flag`.
- `logger.channel.audit_trail_flag` — a `LoggerChannel` named `audit_trail_flag`, used only to log
  internal failures (see error handling below).

## Subscribed events (`AuditTrailFlagSubscriber::getSubscribedEvents()`)

| Flag event | Handler | Payload |
| --- | --- | --- |
| `FlagEvents::ENTITY_FLAGGED` | `onFlag(FlaggingEvent)` | one flagging → `logFlagging($event->getFlagging(), 'flag')` |
| `FlagEvents::ENTITY_UNFLAGGED` | `onUnflag(UnflaggingEvent)` | loops `$event->getFlaggings()`, logs each with `'unflag'` |

Unflag operations can remove several flaggings at once (bulk unflag), which is why `onUnflag()`
iterates and emits one audit row per flagging.

## What gets written (`logFlagging(FlaggingInterface $flagging, string $operation)`)

From the flagging it derives: `$flag = $flagging->getFlag()`, the flaggable `$entity`, its id,
entity-type id, and label; `$flag_label = $flag ? $flag->label() : $flagging->getFlagId()` (label
falls back to the flag machine id if the flag entity is unavailable). `$operation` is normalized to
`flagged` / `unflagged`. Then:

```php
$log = [
  'type'        => 'flag',
  'operation'   => $operation,                  // 'flagged' | 'unflagged'
  'description' => $this->t('%flag_label: %entity_type %label', [...]),
  'ref_numeric' => $entity_id,                  // flaggable entity id
  'ref_char'    => admin_audit_trail_safe_truncate($flag_id), // flag machine id
];
admin_audit_trail_insert($log);
```

The `%label` placeholder falls back to `'Id:' . $entity_id` when the entity has no label. The
description is built with `StringTranslationTrait::t()`, so the flag label, entity type, and entity
label are passed as `%`-prefixed placeholders (escaped on render). The actual persistence, storage
schema, and the report/clear UI all belong to `admin_audit_trail`, not this module.

## Error handling

The body of `logFlagging()` is wrapped in try/catch; any `\Exception` is swallowed and reported to
the `audit_trail_flag` logger channel via `$this->logger->error('There was an error logging a flag:
@message', …)`, so a logging failure never breaks the flag/unflag operation itself.

## Verifying it works

1. Ensure a flag exists (Flag module) and flag/unflag any entity.
2. Open the Admin Audit Trail report and filter by the `flag` type.
3. Expect a row per flag action with description like `Interested in: node Basic Page`,
   `ref_numeric` = the entity id, `ref_char` = the flag machine id. A bulk unflag yields multiple
   rows.

Kernel coverage lives in `tests/src/Kernel/AuditTrailFlagSubscriberTest.php` (with a stub
`admin_audit_trail_test_stub.php`).
