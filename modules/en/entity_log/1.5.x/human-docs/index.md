# Entity Log — manual setup guide

**Entity Log** (`entity_log`) keeps an audit trail of changes to the fields you
care about. You tell it which entity types, bundles, and fields to watch, and
whenever one of those fields changes it records the **old value** and the **new
value**, along with who made the change and from what IP address.

It can record those changes in two places, and you can use either or both: to
the **Drupal logger** (dblog / syslog) for a lightweight watchdog-style trail,
or as dedicated **Entity Log entities** — proper content entities you can view,
list, and even build Views reports over. Each log entity captures the changed
field, the old and new values, a reference back to the source entity, the acting
user, and the client hostname.

A few things to keep in mind. Entity Log fires on entity **update** (not on
create or delete), and its diffing is deliberately shallow: it compares the
string forms of the field values, so it is a per-field change history rather
than a full revision diff. It is a good way to get change tracking on sensitive
fields (status flags, prices, roles) without turning on full revisions
everywhere. A row limit keeps the log table from growing forever, pruned
automatically on cron.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   `dynamic_entity_reference` dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — choose your log targets, pick which
   fields to watch, and set the row limit.

## Where it lives in the admin menu

- The settings form is at **Configuration → Entity Log** (`/admin/config/entity-log`).
- The recorded log entities are listed at **Structure → Entity log**
  (`/admin/structure/entity_log`), where you can view individual change records.

## How to use it

1. Open **Configuration → Entity Log** and turn on at least one log target
   (logger and/or Entity Log entities) — if both are off, nothing is recorded.
2. Tick the specific entity types, bundles, and fields you want to watch.
3. Set a **row limit** so old entity-log records are pruned on cron.
4. Save, then edit a watched entity and change one of the watched fields. A
   change record appears in the log and/or under **Structure → Entity log**.
