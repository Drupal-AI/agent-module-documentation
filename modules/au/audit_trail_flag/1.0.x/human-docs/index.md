# Audit Trail Flag — manual setup guide

**Audit Trail Flag** (`audit_trail_flag`) records every flag and unflag operation
as an entry in the **Admin Audit Trail** log. It is a small bridge module with a
single job: an event subscriber listens for the Flag module's *entity flagged* and
*entity unflagged* events and writes a structured row — the flag label, the entity
type, and the entity's id and label — into the existing `admin_audit_trail`
report. Bulk unflag operations log one entry per flagging.

There is deliberately **no UI, route, or permission of its own** — it simply
augments the audit report you already have. Use it when you already run **Flag**
and **Admin Audit Trail** and want an accountability record of who flagged or
unflagged what, and when: editorial flags such as "needs review", spam/report
flags, bookmarking, or any flag-based workflow. Once enabled, flag activity shows
up alongside your other admin audit events with nothing further to configure.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Flag and Admin Audit Trail.

## How to use it

There is nothing to configure. Once **Flag** and **Admin Audit Trail** are present
and this module is enabled, any flag or unflag action is logged automatically.
Review the entries in the usual **Admin Audit Trail** report — each flag row
includes the flag label and the target entity, and you can correlate flag events
with other logged admin actions there.
