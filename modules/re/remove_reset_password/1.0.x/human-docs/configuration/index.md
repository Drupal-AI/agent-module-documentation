# Configuration

## Open the settings form

Go to **Configuration → People → Remove Reset password**
(`/admin/config/people/reset-password-form-settings`). You need core's **Administer
site configuration** permission to reach it.

The form has two checkboxes.

## Remove the "Reset your password" button

This is the main setting. When enabled it does two things:

- **Hides** the *Reset your password* tab on the login page for anonymous
  visitors.
- **Blocks** the password-reset route server-side: any anonymous request to
  `/user/password` is denied (Access Denied), so the reset page can't be reached
  even by typing the URL directly.

Because the block is enforced on the server rather than just hidden in the UI, this
is the setting that genuinely takes self-service password reset away from anonymous
users. Authenticated users are never blocked — the module only denies anonymous
access to that one route.

## Remove all local tabs

When enabled, this hides **every** local tab on the login page, giving you a
clean, single-purpose "Log in" screen.

> **Important:** this option is **visual only**. It hides the tabs but does *not*
> by itself block the password-reset route. If your goal is to actually prevent
> anonymous users reaching `/user/password`, you must enable **Remove the "Reset
> your password" button** — hiding all tabs alone won't stop a direct URL visit.

## Behaviour notes

- The server-side block is tied specifically to the **Remove the "Reset your
  password" button** setting, applies only to **anonymous** users, and affects only
  the `/user/password` route — every other route is untouched.
- The change is fully **reversible**: uncheck the box(es) and save to restore the
  default login page.
- Per-environment overrides are possible via
  `$config['remove_reset_password.settings'][...]` in `settings.php` — for example
  to enforce the block only on production.
