Role Expire makes user roles time-limited: each role a user holds can be given an expiration date/time, and a cron run removes the role (optionally swapping in another) once it passes.

---

The module adds a per-role expiration timestamp for each user, stored in its own `role_expire`
database table (`uid`, `rid`, `expiry_timestamp`). On the user add/edit form it injects a "Role
expiration" field for every expiration-enabled role, accepting an absolute date (`YYYY-MM-DD
HH:MM:SS`) or a relative strtotime string (`1 day`, `3 months`, `1 year`); on the role edit form
it adds a **default duration** for the role, so newly granted roles auto-expire after that span.
Global configuration (`role_expire.config`) holds which roles have expiration enabled/disabled
(`role_expire_disabled_roles`), each role's default duration (`role_expire_default_duration_roles`),
an optional map of which role to assign when one expires (`role_expire_default_roles`), and
whether the user-form expiration details are expanded by default. A `hook_cron()` implementation
finds expired records, removes the role from the user (adding the configured replacement role if
set), deletes the record, and dispatches a `RoleExpiresEvent`. All logic is reachable
programmatically through the `role_expire.api` service (get/set/delete expiry, default durations,
find expired records). It ships permissions, a settings form at
`/admin/config/people/role-expire`, Views field plugins for expiry data, and a D7 migration
source; the optional `role_expire_rules` submodule exposes the behaviour to the Rules module.

---

- Grant a "premium" role that automatically expires after a paid membership period.
- Give a user temporary "editor" access that is revoked after two weeks.
- Set a default duration on a role so every user who gets it expires after, say, 1 year.
- Downgrade a user to a lower role automatically when their current role expires.
- Provide time-limited trial access to gated content.
- Expire a "beta tester" role on a fixed calendar date.
- Set a precise expiry via an absolute `YYYY-MM-DD HH:MM:SS` timestamp on the user form.
- Set a relative expiry like "3 months" without calculating the date by hand.
- Let administrators view and edit each user's role expiration dates on the user edit form.
- Show a user's role expiration dates on their profile via the pseudo-field.
- Remove expired roles automatically on cron without manual cleanup.
- Assign a replacement role (e.g. "alumni") when the "member" role expires.
- Bulk-manage which roles participate in expiration via the settings form.
- Disable expiration for specific roles you never want to auto-remove.
- Programmatically set a role's expiry for a user from custom code (`role_expire.api`).
- Read a user's role expiry timestamp in code to drive access logic.
- Delete a user's role expiry when a subscription is renewed.
- Expose role expiry columns in a Views report of users.
- Enforce expiry policies together with Role Delegation / RoleAssign modules.
- Trigger a Rules reaction when a role expires (via role_expire_rules).
- Set expiry dates on roles when creating users programmatically (default durations apply).
- Migrate Drupal 7 role_expire data using the provided migrate source plugin.
- Notify or act on expiry by subscribing to the RoleExpiresEvent.
- Collapse or expand the role-expiration fields on the user form by default.
- Run time-boxed campaigns where contributor access ends automatically.
