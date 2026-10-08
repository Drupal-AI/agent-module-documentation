# Configuration

Adequate Passwords has one settings form with three choices: how strong passwords
must be, which roles the policy applies to, and whether to congratulate users on a
strong password.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → Adequate Passwords**, or navigate directly to
   `/admin/config/people/adequate_passwords`.

## Minimum password strength

This is the threshold a password must reach to be accepted. Pick one:

- **Strong** — score 80. The most demanding setting.
- **Good** — score 70.
- **Fair** — score 60. The most lenient enforcing setting.
- **Do not check strength** — score 0. Turns enforcement off without uninstalling
  the module, so you can pause the policy and re-enable it later.

The score is calculated the same way as core's strength meter: passwords shorter
than 12 characters are penalised, as are those missing lowercase letters, uppercase
letters, numbers, or punctuation, and a password equal to the username is dropped
sharply. If a submitted password scores below your chosen threshold, the form is
rejected with the specific tips needed to strengthen it.

## Apply to roles

A set of checkboxes lets you limit the policy to particular user roles:

- Tick one or more roles to enforce the policy **only** for users who have them.
- Leave every box **unticked** to apply the policy to **everyone**.

Anonymous users are always excluded automatically — the policy only applies when a
real account is setting a password.

## Enable message when password is adequate

Tick this to show users a confirmation message when their password passes the
strength requirement. Leave it unticked to stay silent and only speak up when a
password is too weak.

## Save

Click **Save configuration**. Changes take effect immediately on the next password
submission. If you set the threshold to **Do not check strength**, or a user's
roles do not match your selected roles, the check simply does nothing for that
case — the module never blocks a login or weakens core's own password handling.
