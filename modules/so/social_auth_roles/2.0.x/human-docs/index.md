# Social Auth Roles — manual setup guide

**Social Auth Roles** (`social_auth_roles`) lets you automatically grant one or
more **roles** to accounts that are created through **Social Auth** — that is,
accounts made when someone signs up via Google, Facebook, Microsoft or any other
Social Auth provider. Crucially, it leaves accounts created the *normal* way (email
registration) untouched. It gives you an admin screen where you pick which existing
Drupal roles new social signups should receive on creation.

The distinction it draws is genuinely useful, and it is one Drupal's built-in
"roles on registration" cannot make, because that setting cannot tell the two
signup paths apart. You might want people who signed in with Google to land in a
different state from people who registered and confirmed an email address — perhaps
a lighter "social" role that a view or permission keys off, perhaps a specific role
because they arrived through a partner. This module hooks the Social Auth
registration event specifically, so only that path is affected. It depends on the
**Social Auth** module (`social_auth`) and has no submodules.

**Settle the security question before you use it, and it is not about the module.**
A role granted automatically at registration is granted to *anyone* who can
complete the social login flow. So the roles you offer here must carry **no
permission that matters** — no content editing beyond a user's own, no
configuration access, nothing that can grant further permissions. Two more things
worth knowing: a **social identity is weaker than email verification, not
stronger** (a provider account can be new, disposable or automated, and the
provider verified an email for its own purposes, not yours); and **the role
sticks** — an account keeps what it was given at creation, so tightening this
configuration later does not affect anyone who already registered.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Social Auth.
2. [Configuration](configuration/index.md) — choose which roles new social
   signups receive.

## Where it lives in the admin menu

The settings form sits at **Configuration → Social API → Social Auth → Roles**
(`/admin/config/social-api/social-auth/roles`, route `social_auth_roles.settings`),
behind the **Administer social api authentication** permission.
