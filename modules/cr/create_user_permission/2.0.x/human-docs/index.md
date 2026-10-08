# Create User Permission — manual setup guide

**Create User Permission** (`create_user_permission`) adds a single new
permission, **Create users**, so that a role can create new accounts *without*
being handed the all-powerful **Administer users** permission. On a stock Drupal
site, the only way to let someone open the *Add user* form is to give them
Administer users — which also lets them edit, block, cancel, and reassign roles
on every account on the site. This module closes that gap and lets you follow the
principle of least privilege.

With the **Create users** permission granted, a role can reach the *Add user*
form at `/admin/people/create`, save new accounts (including through programmatic
or REST creation), and — when the site is in "administrators create accounts"
mode — create those accounts as active and optionally email the new user their
login details. What the permission deliberately does **not** grant is any power
over *existing* users: no editing, no blocking, no cancelling, no role
assignment. That separation is the entire point of the module.

Typical uses are delegating account creation to a support desk, an HR or
membership secretary, a front-desk team, or a partner/reseller — anyone who needs
to onboard people but should never have full user administration. It also means a
compromised low-privilege account can't be used to take over user management.

The module has **no settings page** of its own — its whole surface is that one
permission plus the wiring that enforces it. You "configure" it simply by granting
the permission to the right roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no configuration form. You grant the permission on the standard
permissions page at **People → Permissions** (`/admin/people/permissions`), in the
**Create User Permission** section. The *Add user* form it unlocks is the core one
at **People → Add user** (`/admin/people/create`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Find the **Create User Permission** section and tick **Create users** for each
   role that should be able to create accounts.
4. Click **Save permissions**.

That's it. Members of those roles can now open **People → Add user** and create
accounts, but they still cannot manage existing users unless they *also* have
Administer users.

You can grant or revoke the same permission from the command line:

```bash
drush role:perm:add my_role 'create users'
drush role:perm:remove my_role 'create users'
```

A few things worth knowing:

- **It governs all creation paths, not just the form.** Because the permission is
  enforced at the entity level, it also authorizes programmatic (`User::create()`)
  and REST-based user creation by that account.
- **Active accounts and the notify email.** When your site is set so that only
  administrators create accounts (rather than open public registration), a
  delegated creator's new accounts are saved as **active**, and the *Notify user of
  new account* email checkbox is available to them on the Add user form.
- **Grant it only to trusted roles.** Creating accounts is a real capability, so
  treat **Create users** as sensitive even though it is narrower than Administer
  users.
