# Log — manual setup guide

**Log** (`log`) provides a **"Log" entity type for real-world record keeping** —
and the name is misleading if you were expecting error logging. This is *not*
about PHP errors or watchdog messages. A "log" here is the kind of record an
organisation keeps: an inspection that was carried out, a delivery that was
received, a treatment that was administered, a maintenance job, an observation.
Anything with a date, a subject, a status, and some fields fits the shape.

Building that as a bespoke entity type every time is a lot of boilerplate, so Log
supplies it generically. You define **log types** (bundles) in configuration, each
with its own fields; entities carry **revisions**; and a **workflow state** driven
by the State Machine module lets a record move through stages such as *planned →
done*. It comes from the **farmOS** ecosystem, where it models farm activities, but
nothing about it is agriculture-specific — it works for any operational or audit
record. Reporting is done through Views.

Access is handled properly, with a granular permission set: `access log collection`,
`administer log types` (a restricted permission), `view all log revisions`, and
scoped entity-create checks rather than flat catch-all permissions. Grant these to
the roles that should create, manage, and audit records.

One important compatibility note: this release declares
**`core_version_requirement: ^11.3`** — it targets a recent Drupal 11 minor only,
with **no Drupal 10 support** at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including its
   Entity, State Machine, and Token dependencies) and enable the module.

There is **no single settings form** for this module. Instead you define **log
types** (bundles) and assign permissions, both described under "How to use it"
below.

## Where it lives in the admin menu

- **Log types** are managed under **Structure** (log types are configuration
  bundles, much like content types). Define types there and add fields to each.
- **Logs** (the records themselves) are listed in a **Log** collection, reachable
  by users with the `access log collection` permission.
- **Permissions** are assigned on **People → Permissions**
  (`/admin/people/permissions`).

## How to use it

1. **Define one or more log types.** Under Structure, create the record types you
   need (for example "Inspection" or "Delivery"), and add the fields each should
   carry — dates, references, files, notes, and so on.
2. **Set up the workflow.** Records carry a State Machine workflow state, so a log
   can move from planned to done. Use it to track whether the recorded event has
   actually occurred.
3. **Grant permissions.** Give trusted roles `administer log types` (restricted),
   and give day-to-day users the ability to create logs of the relevant type,
   `access log collection`, and — where auditing matters — `view all log
   revisions`.
4. **Create and manage records.** Users create logs of each type, move them through
   their workflow state, and you report on them through Views. You can also clone a
   repeated record.
