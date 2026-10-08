# Edit own user account permission — manual setup guide

**Edit own user account permission** (`edit_own_user_account_permission`) adds a
single new permission — **"Edit own user account"** — so your site can decide
whether authenticated users are allowed to edit their own profile at all. Drupal
core has no such setting: out of the box, any authenticated user may edit their own
account, and the only way to stop them is a custom access hook. This module turns
that into a checkbox on the Permissions page.

That's the right control for a specific and not‑unusual class of sites. Where
accounts are **provisioned from elsewhere** — an LDAP directory, a SAML identity
provider, a CRM, a student‑records system — the profile fields are copies of
another system's data, and letting a user edit them creates a divergence that gets
silently overwritten at the next sync (or worse, isn't). Where **identity matters
for authorization**, a user who can change their own email can redirect a password
reset, and one who can change their display name can impersonate a colleague
anywhere names are shown. And where support staff maintain accounts deliberately,
self‑editing just produces inconsistent data nobody asked for.

A few important behaviors to understand:

- It gates editing of the **name, email, and password** fields on the user's *own*
  account. Other profile entities are governed by their own separate permissions.
- Disabling the permission only stops a user from editing **their own** profile —
  they can still edit *other* profiles if they hold the appropriate permissions.
- This module's **"Edit own user account"** permission takes **priority over**
  core's User module "Change own username" permission. To let a user change their
  own username, this permission must be checked.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate settings form** — you configure the behavior entirely on
the core Permissions page, described below.

## Where it lives in the admin menu — and the permission model

Everything happens at **People → Permissions**
(`/admin/people/permissions`). After enabling the module you'll find a new
permission, **"Edit own user account"**:

- **Grant it** to a role and those users may edit their own account (name, email,
  password) as they can on a stock Drupal site.
- **Withhold it** and those users can no longer edit their own account — ideal for
  provisioned/managed accounts, or a demo site where you don't want visitors
  changing account data.

Two things to check before you rely on withholding it:

1. **Account recovery must survive.** Password reset and email change are exactly
   what users need when something goes wrong. Establish whether those paths still
   work with the permission withheld — otherwise your support queue becomes the
   recovery mechanism.
2. **Check every other route into the same data.** A profile field editable through
   a webform, a JSON:API PATCH, or a custom form is *not* covered by a permission
   that gates the standard user form. Close those too if the goal is a truly
   locked profile.

> **Take care not to over‑ or under‑grant.** Because this permission interacts with
> core's "Change own username" and only covers the user's own account form, review
> the effect on a test account before rolling it out to real users.
