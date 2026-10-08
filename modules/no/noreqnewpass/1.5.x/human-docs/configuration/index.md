# Configuration

No Request New Password is controlled by a single checkbox on its settings form.

## Turn off the password‑reset flow

1. Log in as a user with the **Administer No Request New Password** permission (an
   administrator by default).
2. Go to **Configuration → People → No Request New Password**
   (`/admin/config/people/noreqnewpass`).
3. Tick **Disable Request new password link**.
4. Click **Save configuration**.

That's it. As soon as you save, the module:

- denies access to `/user/password` (and its REST/HTTP sibling) for everyone, so the reset
  page returns access‑denied;
- removes the "Reset your password" / "Request new password" link from under the login form
  and from the **user login block** in any theme; and
- shows the generic **"Unrecognized username or password."** message on failed logins, with
  no hint pointing users toward a reset — while keeping core's flood protection intact.

Saving through this form automatically rebuilds the router so the route‑access change takes
effect immediately. (If you ever change the setting by other means, run `drush cr` so the
route access is re‑evaluated.)

To restore normal Drupal behavior, come back to the form, untick the box, and save — the
module goes completely inert again.

## The permission

At **People → Permissions** (`/admin/people/permissions`), the **Administer No Request New
Password** permission controls **who may open this settings form and toggle the checkbox**. It
is flagged as security‑sensitive, so grant it only to trusted roles. Note that this permission
does *not* itself change login or reset behavior — that is entirely driven by the checkbox
above.

## Verify it works

With the setting enabled, visit `/user/password` as an anonymous user — you should get
access‑denied rather than the reset form. Check the login form and the user login block: the
"Request new password" link should be gone.
