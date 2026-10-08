<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Trail Flag (audit_trail_flag) — agent index

**Logs every flag/unflag action from the Flag module as an entry in the admin_audit_trail log.**

- **Version:** 1.0.x (1.0.0) · **Core:** ^10 || ^11 · **License:** GPL-2.0-or-later · **Package:** Administration
- **Hard deps:** `admin_audit_trail` (^1.0), `flag` (^5.0). No config, no routes, no permissions, no Drush.
- **What it is:** a bridge module — one hook + one event subscriber. Nothing to configure; enabling it is enough.

## Mechanism (from source)

- `audit_trail_flag.module` → `hook_admin_audit_trail_handlers()` registers a single log handler `flag` (title *"Flag"*), so entries show up filterable under the `flag` type in Admin Audit Trail.
- Service `audit_trail_flag.flag_subscriber` = `Drupal\audit_trail_flag\EventSubscriber\AuditTrailFlagSubscriber` (tagged `event_subscriber`), constructed with the `logger.channel.audit_trail_flag` channel (both declared in `audit_trail_flag.services.yml`).
- Subscribes to `FlagEvents::ENTITY_FLAGGED` → `onFlag()` and `FlagEvents::ENTITY_UNFLAGGED` → `onUnflag()`. Unflag can carry multiple flaggings (bulk), so `onUnflag()` loops `getFlaggings()` and logs one entry each.
- Both call `logFlagging(FlaggingInterface, $operation)`, which writes a row via `admin_audit_trail_insert()`. Errors are caught and sent to the logger channel.

## Log row shape (`logFlagging()`)

`type` = `flag`; `operation` = `flagged` | `unflagged`; `description` = `t('%flag_label: %entity_type %label', …)` (falls back to `Id:<id>` when the entity has no label); `ref_numeric` = flaggable entity id; `ref_char` = `admin_audit_trail_safe_truncate($flag_id)` (the flag machine id). Flag label falls back to `getFlagId()` when the flag entity can't be loaded.

## Solution docs

- The subscriber, the events, the emitted row, and how to operate/verify it → [events/subscriber.md](events/subscriber.md)
