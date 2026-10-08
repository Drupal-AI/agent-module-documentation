# Configuration

Force Password Change has one settings form plus a handful of "trigger" points
scattered on the People screens. This page explains the settings and the four
ways to force a change.

## Open the settings form

1. Log in as a user with the **Administer force changing of passwords**
   permission.
2. Go to **Configuration → People → Force Password Change**, or navigate directly
   to `/admin/config/people/force_password_change`.

## How enforcement is checked

- **When to check** — this controls how aggressively a pending change is enforced:
  - **On every page load** *(default, most secure)* — as soon as a user with a
    pending change loads any page, they are redirected to their edit form to set a
    new password. After they finish, they are returned to the page they were
    heading to.
  - **On login only** — the check runs only when the user logs in, which is
    lighter weight but means a user who is already logged in is not interrupted
    until their next login.

## First‑time login enforcement

- **Force password change on first‑time login** — when turned on, **every new
  account** must change its administrator‑set password the first time the user
  logs in. This is ideal for making sure imported, migrated, or admin‑created
  accounts do not keep a password an administrator knows.

  You can also apply this to a single new account without turning on the site‑wide
  setting: when the site‑wide option is **off**, the user‑registration form shows
  a "Force password change on first‑time login" checkbox for that one account.

## Timed password expiry

- **Enable password expiry** — turn this on to expire passwords automatically
  after a period. You then set an **expiry period per role**, with a **weight**
  (priority) so that when a user has several roles, the highest‑priority role's
  rule applies. For example, you might expire administrators' passwords every 30
  days but authenticated users' only once a year, with the stricter admin rule
  taking priority. When a user's last password change is older than their
  applicable rule, they are forced to change it.

## The four ways to force a change

Forcing a change is a **trigger**, not a saved checkbox — you tick it and submit,
and the affected users get a pending change on their next visit or login:

1. **A whole role, from the settings form** — in the "force users in the following
   roles" section, tick a role and submit. Everyone in that role is forced.
2. **A whole role, from the role edit form** — each role's edit form gains a
   "Force users in this role to change their password" checkbox.
3. **An individual user** — on a user's profile edit form, a "Force this user to
   change their password" checkbox appears (for admins with the permission). The
   same form shows that user's password statistics — when they were last forced
   and last actually changed their password.
4. **A new user on first login** — the register form's checkbox described above.

## Monitoring

The settings page shows, per role, how many users currently have a pending forced
change, and each role's detail page
(`/admin/config/people/force_password_change/list/{role}`) lets you drill into the
individual users with their last‑force and last‑change timestamps — useful before
an audit.

## Emergency off‑switch (if you get locked out)

Because "on every page load" enforcement can, in an edge case, redirect *you* in a
loop, there is a safe way to disable all enforcement without uninstalling. Add
this line to your `settings.php`, do what you need, then remove it:

```php
$config['force_password_change.settings']['enabled'] = FALSE;
```

While that line is present, the module enforces nothing.

## Save

Click **Save configuration** on the settings form to store your choices. Triggers
(the "force" checkboxes) take effect as soon as you submit the form they are on.
