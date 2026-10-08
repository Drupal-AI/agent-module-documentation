Provides a Password Policy constraint that prevents users from reusing their recent (or any) previous passwords.

---

This submodule adds the `password_policy_history_constraint` plugin and records password hashes in a dedicated `password_policy_history` table as users change their passwords. Its setting, `history_repeats`, controls how many of the most recent passwords are checked: a positive number blocks reuse of that many previous passwords, while `0` blocks reuse of *any* password the user has ever used. During validation it queries the stored hashes and uses the core password service to check the candidate against each, failing if a match is found. It injects the database connection and the password service. Add it to a policy on the Password Policy admin screen. Config schema lives at `password_policy.constraint.plugin.password_policy_history_constraint`.

---

- Prevent users from reusing their last N passwords.
- Block reuse of any previously used password (history_repeats = 0).
- Stop users from cycling back to a favorite password after a reset.
- Enforce a rotation requirement alongside expiration.
- Meet compliance rules mandating no reuse of recent passwords.
- Apply a longer history window to admin roles.
- Provide a clear "you have used this password before" error.
- Show the rule in the live compliance table.
- Combine with time-based expiration for real password rotation.
- Deploy the history rule as exportable policy config.
- Differentiate history depth per role via separate policies.
- Add the constraint to an existing multi-constraint policy.
- Securely compare against hashed history via the core password service.
- Discourage two-password ping-pong on forced resets.
- Keep an auditable history of password changes per user.
- Require genuinely new passwords at each change.
- Strengthen a rotation policy for privileged accounts.
- Layer with length/complexity for defense in depth.
