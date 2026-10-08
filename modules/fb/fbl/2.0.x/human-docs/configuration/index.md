# Configuration

Field Based Login is configured at **Configuration → People → Field Based Login**
(`/admin/config/people/fbl`, route `fbl.configuration`). Access requires the
*administer fbl* permission.

## Choose the login field

The main setting is the **user account field** to use as a login identifier. The
dropdown lists eligible user fields (such as a custom text or telephone field you
have added to the user entity). Pick the one users should be able to log in with —
for example a *Mobile number* field.

> **The login field must be unique.** An identifier has to map to exactly one
> account. If two users share the same value, login becomes ambiguous — so use a
> field whose values are unique across all users.

## Choose which login methods are allowed

Alongside the custom field you decide which login methods are accepted:

- **Allow username login** — keep the normal Drupal username as a valid login
  identifier (on by default). Turn it off if you want users to log in *only* with
  the alternative field.
- **Allow email login** — let users sign in with their email address.

You can combine these — for example, allow both the username and a mobile number.

## Customise the login‑form label

You can override the **label** and **description** shown on the login form's
identifier field, so it reads (for example) "Mobile number" instead of "Username".
If you enabled the core Configuration Translation module, these strings can be
translated per language.

## How authentication stays safe

When someone submits the login form, Field Based Login looks up the account by the
value they entered (by your chosen field, by username, or by email, according to
what you allowed) and rewrites the form's username to that account's real username.
**Drupal core then verifies the password.** The module never checks the password
itself, so a wrong password still fails and core's flood protection still applies.
Lookup failures return a neutral "unrecognized username or password" message rather
than revealing whether an identifier exists.

## Save

Click **Save configuration**. The new login options take effect immediately on the
user login form.
