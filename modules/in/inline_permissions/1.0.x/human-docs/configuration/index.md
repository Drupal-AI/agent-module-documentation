# Configuration

Inline Permissions has no separate settings form to fill in. Its "configuration"
is really an **access model**: it adds per‑user permission granting to the user
edit form, layered on top of Drupal's normal role‑based permissions. This page
explains how that model works and how to use it safely.

## How the access model works

- **Roles still work exactly as before.** Users continue to inherit every
  permission granted to their roles on **People → Permissions**. Inline
  Permissions does not replace that — it adds to it.
- **Per‑user grants are additive.** Using Drupal's core **Access Policy API**, the
  module contributes the permissions you tick for an individual user *on top of*
  what their roles already grant. In other words, you can give one account an extra
  capability without touching any role.
- **The whole feature is gated by "Administer permissions."** Only users who hold
  the core **Administer permissions** permission see the per‑user control and can
  change it. This is deliberately the same permission that guards the site‑wide
  permissions page, because granting individual permissions is just as sensitive.

## Granting permissions to an individual user

1. Log in as a user with the **Administer permissions** permission.
2. Go to **People**, find the account, and click **Edit** (`/user/{uid}/edit`).
3. Use the permissions control the module adds to the form to select the specific
   permissions this user should have in addition to their roles.
4. Save the user form. The grants take effect for that account.

## Use it sparingly, and audit it

Per‑user grants are powerful precisely because they sit outside the role model:

- They can **escalate a user's privileges** beyond what any role would show, so a
  review of roles alone will not reveal them. When you audit access, remember to
  check individual accounts too.
- Because they are attached to one account, they are **easy to forget**. Prefer a
  role whenever more than one person needs the same capability, and reserve
  per‑user grants for genuine one‑offs.
- Keep the **Administer permissions** permission restricted to a very small set of
  trusted administrators — anyone who has it can grant any permission, to anyone.
