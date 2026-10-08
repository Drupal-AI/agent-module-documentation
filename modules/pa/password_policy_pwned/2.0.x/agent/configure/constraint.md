# Configure the Pwned Passwords constraint

The module adds a constraint to the **Password Policy** module; it has no page of its own.

## Add it to a policy
1. Enable `password_policy` and `password_policy_pwned`.
2. Go to *Admin → Configuration → Security → Password Policy* (`/admin/config/security/password-policy`),
   add or edit a policy.
3. On the *Constraints* step add **Pwned Passwords**.
4. Set **Minimum number of occurrences** and save; assign the policy to one or more roles.

## The one setting
- `min_occurrences` (integer, default `1`) — a password is rejected when its breach count is
  `>= min_occurrences`. `1` = reject any password seen in a breach even once. Validation requires
  a positive number (`buildConfigurationForm` / `validateConfigurationForm` in
  `src/Plugin/PasswordConstraint/PasswordPwned.php`).

Config lives inside the `password_policy` config entity's constraint list; schema type
`password_policy.constraint.plugin.pwned_passwords` (`config/schema/password_policy_pwned.schema.yml`).

## Behavior notes
- Validation error message on failure: *"Password has been exposed :occurrences time(s) in data
  breaches…"*.
- Empty password → constraint passes (returns empty validation), leaving "required" to core.
- **Fails open:** if the HIBP API errors/times out (10s), occurrences is treated as `0` and the
  password is allowed; the exception is logged to the `password_policy_pwned` channel. If you need a
  hard fail-closed policy, that is not provided out of the box.
- The check runs on every password set/change for users the policy applies to, adding one outbound
  HTTPS request per validation.
