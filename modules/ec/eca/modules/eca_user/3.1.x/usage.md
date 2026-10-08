ECA User adds user-account events, conditions, and actions to ECA — reacting to login, logout, cancel and other account events, checking roles and permissions, and loading, creating, or switching the acting user.

---

This submodule lets models respond to user lifecycle events and make role/permission-aware decisions. Conditions test the current user's or a given user's id, roles, and permissions, so a model can branch on "is admin", "has role editor", or "can do X". Actions load the current user, create a new user account, and switch the acting account — including switching to a service account and switching back — which is essential when a model must run steps as a different user or with elevated/reduced privileges. It also exposes a user's preferred langcode. Combined with eca_base and eca_content, it powers onboarding automations, role assignment, and access-sensitive workflows. It registers into ECA Core's managers and defines no new plugin types.

---

- React when a user logs in or out.
- Run onboarding steps when a new account is created.
- Branch a model on the current user's role.
- Branch on whether the current user has a permission.
- Check a specific user's id, role, or permission.
- Load the current user entity for later steps.
- Create a new user account from a model.
- Switch the acting account to run steps as another user.
- Switch to a dedicated service account for privileged work.
- Switch back to the original account afterwards.
- Get a user's preferred language code.
- Assign or verify roles as part of a workflow.
- Restrict actions to authenticated vs. anonymous users.
- Send a welcome message on registration.
- Gate content operations by the current user's permissions.
- Automate role changes when profile fields change.
- Run cleanup steps when an account is cancelled.
- Enforce per-role business rules declaratively.
- Impersonate a user safely for a scoped operation.
- Localize downstream actions using the user's langcode.
