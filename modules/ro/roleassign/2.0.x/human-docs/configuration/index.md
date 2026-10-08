# Configuration

Setting up RoleAssign is two steps: choose **which roles are assignable**, then
grant the **Assign roles** permission to the role that should manage other users.

## Step 1 — Choose the assignable roles

1. Log in as a user with core's **Administer permissions** (a trusted site
   administrator).
2. Go to **People → Role assign**, or navigate directly to
   `/admin/config/people/roleassign`.
3. You'll see a **Roles** checkbox set listing every role on the site except
   *Anonymous* and *Authenticated* (those two are never assignable). Tick the
   roles a delegated user administrator is allowed to hand out — for example
   *Editor* and *Moderator*.
4. Click **Save configuration**.

The chosen roles are stored in the `roleassign.settings` config object (key
`roleassign_roles`).

## Step 2 — Grant the delegation permissions

On **People → Permissions**, give your assistant-admin role **both** of these:

- **Assign roles** (`assign roles`) — from this module. It is marked as
  security-sensitive.
- **Administer users** (`administer users`) — from core. This lets the user edit
  accounts in the first place.

A user only becomes "restricted" (their role choices limited to the assignable
set) when they have *Assign roles* and *Administer users* but **not** *Administer
permissions*. Anyone who holds *Administer permissions* keeps the full,
unrestricted roles field.

> **Security note:** *Administer users* is powerful — it can change other users'
> passwords and email addresses. Grant it only to trusted assistant admins. For an
> extra layer of safety (locking specific accounts or fields), consider pairing it
> with the User Protect module.

## How the restriction behaves

Once configured, when a restricted admin edits a user account:

- The roles field is replaced by an **Assignable roles** checkbox set containing
  only the roles you approved.
- Any roles the account already has that are *not* in the assignable set are kept
  as "sticky" — shown but not editable — so the restricted admin can neither add
  nor remove them.
- The rule is enforced on save (server-side), not just in the form, so it can't be
  bypassed by tampering with the page.
- User 1's name, email, and password remain protected.

## Doing it from the command line

The assignable roles are a config value, so you can set them with Drush and deploy
them as exported configuration:

```bash
drush cset roleassign.settings roleassign_roles.0 editor
drush cset roleassign.settings roleassign_roles.1 moderator
```

`drush config:export` / `config:import` carry the setting between environments.
