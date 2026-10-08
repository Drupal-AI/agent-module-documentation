# Disable user deletion — manual setup guide

**Disable user deletion** (`disable_user_deletion`) removes the destructive
"delete the account" choices from Drupal's account‑cancellation forms, so
administrators are steered toward safe options and away from permanently deleting
users. It's aimed at multi‑admin sites and organizations with a "never
hard‑delete users" policy.

When someone cancels a user account, core normally offers several methods:
disable the account (keep content), disable and unpublish content, delete the
account and reassign its content to Anonymous, or delete the account and its
content outright. This module lets you hide any of the three destructive methods
from both the single‑user cancel form and the bulk cancel‑confirm form. A short
warning appears in place of the hidden options telling the admin to contact a
technical administrator. The non‑destructive "disable the account and keep its
content" method is always left available.

You choose which methods to hide from a single settings form with three
checkboxes. The choices are stored in ordinary configuration, so you can export
them and deploy the same policy across environments.

> **Important — this is a guardrail, not a security boundary.** The module only
> hides radio options from the rendered form; it does not add server‑side
> validation, and it defines no permission of its own. The real ability to cancel
> accounts is still governed by core's *Administer users* / cancel‑account
> rights. Treat this as a convenience for trusted admins to prevent accidental
> deletions, and keep using proper role and permission scoping for actual access
> control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — pick which cancellation methods to
   hide.

## Where it lives in the admin menu

The settings form is at **Configuration → Disable user deletion → Settings**
(`/admin/config/disable_user_deletion/settings`). It is gated by core's
*Administer site configuration* permission. The effect shows up on the user
cancel forms (for example `/user/*/cancel` and the bulk cancel confirmation).
