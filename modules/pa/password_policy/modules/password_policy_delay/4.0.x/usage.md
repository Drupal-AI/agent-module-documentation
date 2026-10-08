Provides a Password Policy constraint that enforces a minimum waiting period before a password can be changed again.

---

This submodule adds the `password_policy_delay_constraint` plugin. Its setting, `delay`, is a number of hours that must elapse after the last password change before another change is allowed. During validation it reads the user's `field_last_password_reset` value, adds the configured delay, and fails if that time has not yet passed. This is a "minimum password age" rule — commonly paired with password history to stop users from rapidly cycling through several passwords to defeat reuse restrictions and return to a favorite. It injects the database connection and the core password service. Add it to a policy on the Password Policy admin screen. Config schema lives at `password_policy.constraint.plugin.password_policy_delay_constraint`.

---

- Enforce a minimum password age (e.g. 24 hours) between changes.
- Prevent rapid password cycling to defeat history rules.
- Pair with password history for effective rotation enforcement.
- Stop users from resetting a password immediately after a change.
- Apply a longer minimum age to privileged roles.
- Provide a clear "not enough time has passed" error.
- Show the rule in the live compliance table.
- Deploy the delay rule as exportable policy config.
- Differentiate delay windows per role via separate policies.
- Reduce churn on high-security accounts.
- Add the constraint to an existing multi-constraint policy.
- Read the last-reset field to compute eligibility.
- Combine with expiration to shape a full rotation lifecycle.
- Discourage impulsive repeated resets.
- Set a short delay for general users and longer for admins.
- Meet compliance rules specifying minimum password age.
- Prevent gaming of the no-reuse constraint.
- Enforce the delay site-wide via a broad policy.
