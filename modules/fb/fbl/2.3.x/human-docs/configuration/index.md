# Configuration

Field Based Login is configured at **Configuration → People → Field Based Login**
(`/admin/config/people/fbl`, route `fbl.configuration`). Access requires the
*administer fbl* permission. All settings are saved to the `fbl.settings`
configuration object.

## Choose the login field

The **field** dropdown lists user account fields eligible to be a login identifier —
only fields on the *user* bundle of type **string**, **integer**, or **telephone**
appear (core base fields are excluded). Pick the field users should log in with, for
example a *Mobile number* or *Membership number* field. Leaving it empty disables
field‑based login (in which case you must keep username login on).

> **The login field must be unique.** This version enforces that for you: the
> settings form **refuses to save** a field that already has duplicate values across
> users, and the user register/edit form **blocks saving a duplicate** value later.
> If a field is not marked required, or some users have no value yet, the form warns
> you (but still saves).

## Choose which login methods are allowed

- **Allow username login** — keep the normal Drupal username as a valid identifier
  (on by default). Turn it off to force login with the alternative field only.
- **Allow email login** — let users sign in with their email address (off by
  default).

You can combine methods — for example, allow both a mobile number and the username.

## Email source (when email login is on)

When email login is enabled, the **email source** setting controls which name the
module resolves the email to before core authenticates:

- **Display name** *(default)* — resolve to the account's display name.
- **Account name** — resolve to the raw account (login) name.

## Customise the login‑form label and description

- **Label** — override the `#title` of the identifier field on the login form (for
  example "Mobile number" instead of "Username").
- **Description** — set the help text shown beneath that field.

Both strings are sanitised on save. With the core Configuration Translation module
enabled, they can be translated per language.

## How authentication stays safe

On submit, Field Based Login looks up the account by your chosen field, then by
username (if allowed), then by email (if allowed); the first match rewrites the
form's username to that account's real username so **Drupal core verifies the
password**. The module never checks the password itself, so a wrong password still
fails and core flood control still applies. If a field lookup matches **more than
one account, login is rejected** rather than guessing, and failed lookups return a
neutral "unrecognized username or password" message.

## Save

Click **Save configuration**. Changes take effect immediately on the user login
form. Remember the form will not save if the chosen field has duplicate values, or if
you have disabled every login method at once.
