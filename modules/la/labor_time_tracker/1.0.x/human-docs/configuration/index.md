# Configuration

Labor Time Tracker's management happens across a small set of admin pages under
**Configuration → Labor time**, all reachable by users with the **administer labor
time tracker** permission. Collaborators, meanwhile, use their two front‑end pages
(see the [overview](../index.md)).

## Settings — expected daily hours

**`/admin/config/labor-time/settings`**

This is the module's settings page. Here you define **how many hours a collaborator
is expected to work on a daily basis**. That expected figure is what the labor
report measures actual logged hours against, so set it to match your standard
working day.

## Log list — manage recorded times

**`/admin/config/labor-time/log-list`**

A list of every labor time log. From here a manager can **add, edit, and delete**
records — useful for fixing a forgotten clock‑out or entering time on behalf of
someone. Each log carries the user, the enter and exit timestamps, and the
automatically calculated duration.

## Request list — approve or reject changes

**`/admin/config/labor-time/request-list`**

Collaborators can't silently rewrite their own hours; instead they submit change
requests from `/labor-info/time-log-request`. This page lists those requests, each
with the referenced time log, the proposed enter/exit dates, and the stated reason.
A manager **accepts or rejects** each one. Only on approval is the change applied to
the underlying time log, which keeps a clear audit trail.

## Log report — worked hours per user

**`/admin/config/labor-time/log-report`**

A report that tracks the hours each user has logged, so you can see who has met the
expected daily hours set on the settings page and review attendance over time.

## Permissions

Assign the two permissions on **People → Permissions**:

- **administer labor time tracker** — full access to the four admin pages above.
- **view labor times** — permission to view recorded times.

Because these pages expose personal attendance data, keep the permissions limited
to the people who need them and handle the data per your privacy policy.
