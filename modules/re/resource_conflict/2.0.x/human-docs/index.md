# Resource Conflict — manual setup guide

**Resource Conflict** (`resource_conflict`) prevents double-booking of time-based
content. It watches nodes that use a **Date range** field and stops editors from
saving an entry whose dates overlap an existing one — listing the conflicting nodes
so the editor can adjust the dates instead of creating a clash. Typical uses are
booking rooms, lab or AV equipment, or any shared resource where only one thing can
be scheduled for a given span of time.

The check runs both when a node form is validated and again during entity presave,
so conflicts are caught whether a person is editing in the UI or code is saving a
node programmatically. You can add optional **time buffers** — a few minutes of
padding before or after each event — and you can decide whether conflicts are
checked only within a single content type or across every type that shares the same
Date range field.

Setup is done per content type, on the content type's own edit form under
**Additional settings → Resource conflict** — there is no separate central settings
page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Configuration happens per content type, described in "How to use it" below.

## Where it lives in the admin menu

There is no dedicated admin page. You enable and tune conflict checking on each
content type at **Structure → Content types → *(your type)* → Edit → Additional
settings → Resource conflict**.

## How to use it

1. Add a **Date range** field to each content type that should be checked for time
   clashes (**Manage fields → Add field → Date range**).
2. Edit the content type (**Structure → Content types → *(your type)* → Edit**) and
   open **Additional settings → Resource conflict**.
3. **Enable conflict checking** and pick the **Date range field** to compare on.
4. Optionally add **start/end buffers** using `strtotime()`-style expressions — for
   example `-5 minutes` to pad the start time so events have a little breathing room.
5. Decide on scope: if the same Date range field is shared across several content
   types, conflicts can span all of them; tick **Restrict conflicts to this content
   type** to keep the check within this bundle only.
6. Optionally turn off **Show a default validation error** if you plan to handle
   conflicts entirely in custom code.
7. Save the content type.

Repeat for each content type you want protected. From then on, saving a node whose
dates overlap another is blocked and the conflicting nodes are listed.

> **For developers:** Resource Conflict fires Symfony events
> (`resource_conflict.conflict_validation` and `resource_conflict.conflicts_filter`)
> so other modules can inspect, filter, or replace the conflict logic. See the
> sibling [`agent/`](../agent/start.md) docs and the project page for details.
