# Bulk Update User Roles — manual setup guide

**Bulk Update User Roles** (`bulk_update_user_roles`) adds or removes a role
across **all users at once**. Instead of editing accounts one at a time, you open
a single form, pick a role, choose whether to add or remove it, and the module
applies that change to every user in one batch. It's built for mass role
management and depends only on core's User module.

The tool is a single admin form with no other configuration.

## Who can use it

The form lives under **Configuration → People** and is available to accounts with
the **`administer users`** permission. Because it changes role membership in bulk —
including the ability to add or remove any site role across many accounts at once —
treat access to it the way you treat any user-administration capability: grant it
only to trusted staff, and review who holds `administer users` on your site. As with
all mass operations, double-check the role and the add/remove choice before you
submit, since the change is applied immediately across the target accounts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The form lives under **Configuration → People**, at
`/admin/config/people/bulk-update`. Reaching it requires the `administer users`
permission.

## How to use it

1. Go to `/admin/config/people/bulk-update`.
2. Choose the role(s) to apply, and whether to **add** or **remove** them.
3. Submit to run the batch across all users.

Because this applies a role change to many accounts in one step, keep access
limited to trusted administrators and confirm your selections before submitting.
