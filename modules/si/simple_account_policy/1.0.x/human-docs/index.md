# Account policy — manual setup guide

**Account policy** (`simple_account_policy`) applies the handful of account rules
that security questionnaires and IT policies keep asking about — do passwords
expire, are dormant accounts disabled, is an email address enforced as the
username — without the configuration surface of the full Password Policy stack.
Drupal core answers none of these on its own, and the established heavyweight
answer is the Password Policy module with its constraint plugins. This module takes
the lighter path when your requirement is just a small, fixed baseline.

Once enabled it enforces its rules on each request (via an event subscriber) and
on a cron interval, and it ships with sensible defaults so it does something
reasonable out of the box: usernames must match the email address, inactive users
are blocked after three months (with a warning email three weeks before), and an
account still inactive after a year is removed. It also adds two operations to a
user account — **Activate** (unblock a user and clear their flood/lockout record)
and **Block** — reachable from the People screen. It depends only on core's
**User** module and has no submodules.

The permission set is well designed and correctly locked down: *administer account
policy*, *account policy activate users*, and *account policy block users* are all
marked as restricted-access, which is right — being able to activate an account is
effectively the ability to restore access to a disabled user, so treat it as an
account-recovery capability rather than a convenience. The module also provides
tokens (used in the warning/notification emails) so you can personalise those
messages.

One important thing to plan before you switch on automatic blocking: dormancy
rules will eventually catch **service accounts**, integration users, and rarely
used administrator accounts. Locking out the very account you would need to fix the
problem is the classic failure here, so work out your exemptions first. Note also
that this project's stable branch is a pre-release; test on a non-production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the account-policy rules, field by
   field, and the manual activate/block operations.

## Where it lives in the admin menu

The settings live under **Configuration → People → Account policy**
(`/admin/config/people/account_policy`), governed by the *Administer account
policy* permission. The per-user **Activate** and **Block** operations appear on
the **People** screen (`/admin/people`) and are gated by their own dedicated
permissions.
