# Admin Denied — manual setup guide

**Admin Denied** (`admin_denied`) hardens Drupal's superuser account, **user 1**, by
preventing anyone from logging in to it with a password. User 1 is Drupal's
all‑powerful account, and a password on it is a liability: it is the single most
valuable credential for an attacker to brute‑force or phish, and a shared user‑1
login destroys per‑person accountability.

To close that gap, Admin Denied randomizes user 1's username and password (on cron,
using a configurable prefix) so that no one can log in as user 1 with a password
any more. Administrators instead sign in with their own named accounts that carry
the administrator role — which restores accountability and removes the high‑value
target. This is a well‑established, genuinely useful hardening practice for any site
that cares about admin‑account hygiene.

There is one important operational note: **don't lock yourself out.** Before you
rely on this module, make sure at least one trusted, *named* account already has the
administrator role, because user 1's password login is being taken away.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Admin Denied has **no settings form and no admin page**. Its protection is entirely
automatic once the module is enabled — the credential randomizing happens on cron
runs.

## How to use it

1. **First, make sure you have a safe way in.** Confirm that at least one named user
   account (not user 1) has the administrator role and that you can log in with it.
2. Enable the module (see [Installation](installation/index.md)).
3. On the next cron run, user 1's username and password are randomized, disabling
   password login for that account. From then on, use your own named administrator
   account to manage the site.

Enable it when you want this hardening; leave it disabled if you still rely on
logging in as user 1.
