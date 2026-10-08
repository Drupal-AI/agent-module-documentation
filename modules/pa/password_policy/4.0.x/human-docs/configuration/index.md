# Configuration — the policies list

Password Policy has no site-wide settings screen to fill in first. Instead, all of
your work happens on the **Password Policies** list, where each **policy** you
create is a self-contained bundle of rules aimed at particular roles.

## Open the policies list

1. Go to **Configuration → Security → Password Policy**
   (`/admin/config/security/password-policy`).

![The Password Policies list](../images/list.png)

The list shows every policy on the site, with its human-readable **Password
Policy** name, its **Machine name**, and an **Operations** column for editing or
deleting it. On a fresh install it reads *"There are no Password Policies yet."*

Two buttons sit above the list:

- **+ Add Policy** — start a new policy. This is covered step by step in
  [Creating a policy](../creating-a-policy/index.md).
- **+ Force Password Reset** — immediately expire the passwords of everyone in the
  roles you select, so they must set a new password on their next request. Use this
  when, for example, credentials may have leaked and you want to force a rotation
  right away rather than waiting for scheduled expiration.

## How a policy works

Think of a policy as answering three questions:

1. **Which roles does it apply to?** A user is subject to a policy if they hold any
   of the roles it targets. If a user matches more than one policy, *all* of those
   policies' constraints must pass.
2. **What must a password satisfy?** A policy holds an ordered set of
   **constraints** — the individual rules such as minimum length, required
   character types, or password history. Each constraint comes from a
   [submodule you enabled](../installation/index.md) and has its own settings.
3. **When does the password expire?** A policy can define a reset interval in days,
   plus optional reminder and notification emails, so passwords age out and users
   are forced to choose a new one.

Because constraints only appear once their submodule is enabled, the exact rules
available to you depend on which submodules you turned on during
[installation](../installation/index.md). Each policy is stored as ordinary Drupal
configuration, so you can export it and deploy it across environments like any
other config.

When you are ready, move on to [Creating a policy](../creating-a-policy/index.md).
