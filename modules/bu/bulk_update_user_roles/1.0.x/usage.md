Bulk Update User Roles lets administrators assign or remove roles for many users at once from a single form.

---

Bulk Update User Roles provides one admin form (at `/admin/config/people/bulk-update`, under
Configuration → People) for **mass role management**. Pick "Assign roles" or "Remove roles",
choose one or more roles and either a set of individually selected users or all users, and submit;
the change runs as a Batch API job that loads each account and calls `addRole()`/`removeRole()`
then saves it. User id 1 is always excluded from the operation. The module depends only on core
User and adds no entities, plugins, permissions of its own, or config objects — it is a thin
convenience wrapper over core role assignment for doing it in bulk instead of one account at a
time.

---

- Assign a role to many users in one submission.
- Remove a role from many users in one submission.
- Assign or remove several roles at once (multi-select).
- Apply a role change to all users with the "Select all users" checkbox.
- Apply a role change to a hand-picked subset via the users multi-select.
- Onboard a batch of accounts by granting a shared role in one step.
- Offboard a batch of accounts by stripping a role in one step.
- Migrate users from one role to another (add the new role in bulk, then remove the old one).
- Roll out a new role to an existing user base after creating it.
- Retire a deprecated role by removing it from everyone who has it.
- Grant a temporary campaign/event role to many users, then remove it later.
- Clean up role assignments after a permissions restructure.
- Run the change as a progress-tracked Batch job (init/progress/finished messages).
- Handle large user bases without editing each account form individually.
- See the available (non-uid-1) user count before submitting.
- Keep uid 1 untouched — it is always excluded from bulk updates.
- Reach the form from the admin menu under Configuration → People (`user.admin_index`).
- Confirm results via the "Assigned/Removed role to N users" message on completion.
- Operate entirely through the UI — no Drush command or config export needed.
