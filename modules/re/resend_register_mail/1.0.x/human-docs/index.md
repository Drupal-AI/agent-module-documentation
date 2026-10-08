# Resend registration / welcome email — manual setup guide

**Resend registration / welcome email** (`resend_register_mail`) adds a bulk action
to the People screen that re-sends the account registration / welcome email to the
user accounts you select. It is handy when an onboarding email bounced, got lost,
or when accounts were created in bulk (through an import or migration) and never
received their welcome message. The module is a contributed version of work
happening in a Drupal core patch.

There is nothing to configure — you use it entirely from the built-in People
listing, by selecting accounts and choosing the resend action.

> **This action can be close to account takeover — grant access carefully.**
> Depending on which mail type is configured, resending can regenerate a one-time
> login link for the target account. For that reason the module's **Resend account
> emails** permission is deliberately restricted. Give it only to trusted
> administrators, and be deliberate about which mail type you resend to a general
> support role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no configuration page — the module provides no settings; usage is
described below.

## Where it lives in the admin menu

The action appears in the bulk-operations dropdown on the **People** screen
(**Manage → People**, `/admin/people`). The action itself runs at
`/admin/user/resend-email` once accounts are selected. Access requires either the
core **Administer users** permission or the module's own **Resend account emails**
permission.

## How to use it

1. Go to **People** (`/admin/people`).
2. Tick the checkbox next to each account that should receive the email again.
3. From the **Action** dropdown at the top of the list, choose the resend
   registration / welcome email action, then click **Apply to selected items**.
4. Confirm on the resulting screen to send the emails.

The selected users are then re-sent the registration / welcome mail according to
the mail type your site has configured.
