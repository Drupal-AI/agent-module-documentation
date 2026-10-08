# CAS User Ban — manual setup guide

**CAS User Ban** (`cas_user_ban`) prevents Drupal accounts from being created for
banned **CAS** usernames. It works alongside the **CAS** module, which can be
configured to automatically create a Drupal account the first time someone logs in
via CAS single sign-on. That convenience has a downside: if a user has posted
unwanted content (spam, say) and you delete both the user and their content, the
account is simply recreated the next time that CAS identity logs in. CAS User Ban
closes that loop.

When you delete a user, this module adds an option to **ban** the account at the same
time — blocking any future recreation of a Drupal account for that CAS username. In
other words, it lets you delete *and* ban in one step, so the offending CAS identity
cannot log back in and regenerate their account. It maintains a targeted deny-list of
CAS usernames on top of CAS SSO.

One limitation to be aware of: the module does **not** block login for *existing*
users who happen to have a banned CAS username — it prevents *creation* of new
accounts, not access for accounts that already exist. It has no broader
access-control role. Because banning someone is a sensitive action, restrict who can
manage the ban list to trusted administrators, and keep the list accurate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the CAS module.

There is no dedicated settings page — banning happens as part of the user-deletion
flow, described in "How to use it" below.

## Where it lives in the admin menu

CAS User Ban adds no standalone settings form. It surfaces its **ban** option on the
standard user-deletion flow under **People** (`/admin/people`). Restrict user
administration (and therefore banning) to trusted administrators.

## How to use it

1. Go to **People** (`/admin/people`) and delete the user you want to remove, as you
   normally would.
2. During deletion, choose the **ban** option that CAS User Ban adds. This records
   the user's CAS username on the ban list.
3. From then on, that CAS username can no longer trigger automatic account creation
   on CAS login — so the account will not be regenerated.

Remember this stops *recreation* of accounts; it does not revoke access for an
existing account that already shares a banned CAS username.
