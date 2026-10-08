Role Expire Rules is a glue submodule that exposes Role Expire to the Rules module: two Rules actions to set or remove a user's role expiry, and a Rules event that fires when a role expires.

---

The submodule adds Drupal Rules integration for Role Expire. It defines two `@RulesAction`
plugins — `role_expire_set_expire_time` ("Set expire time for user roles") and
`role_expire_remove_expire_time` ("Remove expire time for user roles") — both in the "User"
category, that call the parent module's `role_expire.api` service under the hood (`writeRecord()`
and `deleteRecord()`). The set action takes a user, one or more role IDs, and a date (absolute
`YYYY-MM-DD HH:MM:SS` or relative strtotime like `1 day`/`2 months`) and only applies to roles the
user actually holds. It also registers a Rules **event**, `role_expire_event_role_expires`
("When a role expires", category "User"), backed by the parent module's `RoleExpiresEvent`, with
context `account` (the user) and `ridBefore` (the expired role id). With these you can build
reaction rules such as "when a role expires, email the user" or "when a user is created, set their
premium role to expire in 30 days" entirely in the Rules UI. It has no config, permissions, forms
or Drush of its own; it requires `role_expire` and `rules`.

---

- Set a user's role to expire on a chosen date via a Rules reaction rule.
- Grant a role and set it to expire in "1 month" using a Rules action, no code.
- Remove a role's expiry (make it permanent) through a Rules action.
- React when a role expires by sending the user a notification email.
- Log an event whenever any role expires using the role-expired Rules event.
- Assign a follow-up task or flag when a user's role expires.
- Set expiry on multiple roles at once from a single Rules action.
- Combine with "after saving a new user" to auto-expire a trial role.
- Extend a subscription by re-running the set-expire action with a later date.
- Clear expiry when a payment succeeds (remove-expire action in a reaction rule).
- Use relative durations (e.g. "3 months") in a Rules action without date math.
- Drive role lifecycle from Rules components reused across multiple events.
- Trigger downstream Rules logic (webhooks, messages) on role expiry.
- Only affect roles the user already has (the set action skips roles they lack).
- Build "membership expired" workflows without writing an event subscriber.
- Set a role to expire when a user joins a group or completes an action.
- Automate temporary elevated-access grants with automatic revocation.
- Integrate role expiry into larger Rules-based business processes.
- React to expiry with the `account` and `ridBefore` context provided by the event.
- Schedule role changes declaratively rather than in custom PHP.
