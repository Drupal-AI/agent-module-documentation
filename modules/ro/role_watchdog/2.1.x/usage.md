<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Watchdog automatically records every user-role addition and removal (made via the user profile, the user list, or account creation) as its own audit entity, shows a role-history tab per user, and can email selected roles when watched roles change.

---

The module hooks `hook_user_update` / `hook_user_insert` / `hook_user_delete` to diff each account's
roles before and after a change and persist a `role_watchdog` content entity per change (action
`ROLE_ADDED`/`ROLE_REMOVED`, the actor uid, the target user, and the affected role ids). It ships three
optional Views (`role_watchdog_history`, `track_role_history`, `track_role_grants`) for browsing the log
and provides an entity collection under *admin/structure/role_watchdog*. A settings form
(`admin/config/people/role_watchdog`, permission `administer role_watchdog`) toggles whether changes are
**also** written to the Drupal logger (`role_watchdog_use_watchdog`, on by default), and configures
optional email notifications: pick *Monitor* roles and a *Notify* email address, and when a monitored
role is added/removed the module emails that address (`role_watchdog_notify` via `hook_mail`). Default
install config sets `role_watchdog_monitor_roles: administrator` and a placeholder
`role_watchdog_notify_email: email@example.com` (notifications only actually send if the email is
non-empty). The module defines two module permissions (`administer role_watchdog`, `access role_watchdog
reports`) plus a role_watchdog entity with its own access handler. Note: the entity's CRUD access handler
references permissions (`view published role watchdog entities`, `add role watchdog entities`, `administer
role watchdog entities`) that the module does **not** declare, so entity add/view routes are effectively
restricted to user 1 unless those permissions are provided elsewhere.

---

- Keep an audit trail of who granted or revoked which role, and on whom.
- Review a per-user "Role history" of all their role changes.
- Detect unauthorized or accidental privilege escalations after the fact.
- Email the security team whenever the Administrator role is added or removed.
- Monitor a specific set of sensitive roles for changes.
- Mirror role changes into the standard Drupal log (dblog/syslog) for centralized logging.
- Satisfy compliance/audit requirements for tracking permission changes.
- Investigate "how did this user become an admin?" by inspecting the log.
- Browse all role grants/removals site-wide via the bundled Views.
- Track role changes made during account creation (initial roles are logged too).
- Notify multiple stakeholders by pointing the notify email at a distribution list.
- Complement Role Delegation / RoleAssign by auditing the delegated grants they enable.
- Alert on removal of a role (e.g. someone losing "editor") as well as additions.
- Keep a record even after the affected user is deleted is cleaned up (delete hook prunes their entries).
- Provide accountability on multi-admin sites where several people can change roles.
- Distinguish the actor (current user) from the target user in each log entry.
- Export the role-change log via a View for reporting.
- Turn off dblog mirroring and rely solely on the module's own entity log.
- Configure which roles trigger email alerts without touching code.
- Use the role-history tab during support to explain a user's current access.
