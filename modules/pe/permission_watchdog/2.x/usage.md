<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permission watchdog records every change made to a role's permissions on Drupal's permissions form — which permission was added or removed, on which role, by which user, and when — and exposes the history as an admin report.

---

Drupal does not log changes to role permissions by default, so a silent grant of an administrative capability to an editor role, or a quiet loosening of access, leaves no trail. Permission watchdog closes that gap. It hooks into the core `user_admin_permissions` form (and the module-, role-, and entity-specific variants of it): before the form is saved it snapshots the tracked roles' current permissions, and on submit it diffs the new checkbox state against the snapshot and writes a `role_change_log` content entity for each role that actually changed — one entity per role per save, with an unlimited-cardinality list of `added`/`removed` permission actions plus the acting user's uid and a timestamp. Administrative (super-admin) roles are excluded because they hold all permissions implicitly and store nothing to diff against. Configuration decides whether every role is watched (the default) or only a selected subset, and a runtime status-report requirement nudges you toward monitoring all roles. The recorded history is presented through a bundled Views report at `admin/reports/permission-watchdog`, gated by its own dedicated permission, with exposed filters for role, permission and action. Because the report reveals the site's permission structure and change history, keep the report permission restricted to trusted auditors and treat unexpected entries as a signal worth investigating.

---

- Log every add/remove of a permission on a role.
- See which user changed a role's permissions.
- Record the exact time a permission change happened.
- Audit the full history of a role's permission changes.
- Prove what permissions a role held at a given point in time.
- Meet security-audit / compliance requirements for permission changes.
- Detect a privilege-escalation change (an editor granted an admin capability).
- Catch a permission being silently loosened or removed.
- Track all roles automatically (default configuration).
- Restrict tracking to a chosen subset of roles.
- Exclude admin roles automatically (they store no comparable permission set).
- Review changes through the built-in Views report at admin/reports/permission-watchdog.
- Filter the report by changed role.
- Filter the report by a specific permission string.
- Filter the report by action (added vs removed).
- Grant read access to the report only to trusted auditors.
- Treat unexpected permission-change entries as an incident signal.
- Group added and removed permissions clearly in each log entry.
- Generate sample log entries for testing with the Devel Generate integration.
- Pair with Role watchdog (user role changes) and Role change notify.
- Add permission-change monitoring to a hardened / regulated site.
- Verify the status report warns when not all roles are monitored.
- Keep a durable record independent of dblog retention limits.
