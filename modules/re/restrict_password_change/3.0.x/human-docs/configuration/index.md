# Configuration

This module has no settings form — you configure it entirely through
**permissions**, on the standard **People → Permissions** page
(`/admin/people/permissions`). None of these permissions are granted by default,
so start by deciding which roles should have which capabilities.

The usual pattern: give a delegated role the core **Administer users**
permission so it can edit accounts, then grant *only* the specific permissions
below that you want it to have. Whatever you withhold is hidden or disabled on the
user edit form for that role.

## Permissions for editing other users

These apply when someone edits **another** person's account:

- **Change other users password** — without it, the password field is removed
  from the user edit form, so the role can't set another user's password.
- **Change other users email** — without it, the email field is shown as
  read‑only (the current value stays visible but can't be changed). Good
  protection against account‑takeover by a lower‑trust admin role.
- **Change other users username** — without it, the username field is likewise
  read‑only.
- **Block other users** — without it, the account status (block / unblock)
  control is hidden.
- **Delete other users** — without it, the Delete action is removed from the
  form.

Because these fields are made inaccessible (not just hidden in the page), Drupal
ignores any value submitted for them — so a restricted admin can't sneak a change
through by crafting a request. The restriction holds on save.

## Permissions for a user's own account

- **Change own password** — without it, both the new‑password and
  current‑password fields are removed when a user edits **their own** account, so
  they can't change their own password. Useful for accounts whose credentials are
  managed elsewhere (for example via SSO).

## Permission for password recovery

- **Reset password by request link** — this governs the "reset your password"
  email. If a recipient's account lacks this permission, the reset email is
  cancelled and not sent — blocking password recovery for that account.

## A note on the security warnings

Most of these permissions carry security implications and are marked as
restricted, so Drupal shows the usual "grant with care" warning next to them on
the permissions page. Due to a small typo in the module's metadata, the **Block
other users** permission doesn't display that warning even though it is meant to
be treated as sensitive — the permission itself still works correctly. Treat it
as a sensitive permission regardless.
