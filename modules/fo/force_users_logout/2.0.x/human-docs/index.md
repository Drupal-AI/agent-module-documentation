# Force Users Logout — manual setup guide

**Force Users Logout** (`force_users_logout`) gives an administrator a simple way
to sign other people out of the site immediately. It provides three small admin
forms — log out **one named user**, log out **everyone holding selected roles**,
or log out **every authenticated user except administrators** — and each one
destroys the targeted users' sessions so their next page request is anonymous
and they have to log in again.

This is handy in a range of situations: offboarding someone the moment their
access is revoked, forcing a fresh login so newly granted roles take effect,
clearing every non-admin session before a database restore or maintenance
window, or responding to a security incident by dropping all sessions except
your own. The user accounts themselves are never touched — only their active
sessions are ended.

The module is UI-only and deliberately minimal: it defines **no permissions of
its own** (access is controlled by core's *Administer users* permission), stores
**no settings**, and adds no services, plugins or Drush commands. The three forms
are actions you run on demand, not configuration you save.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the three logout forms and exactly
   who each one signs out.

## Where it lives in the admin menu

Once enabled, the module adds **Force users logout settings** under
**Configuration → Development** (`/admin/config/force-users-logout/individualuser`).
That page has three tabs — **Individual User**, **Role Based** and **All Other
Users** — one for each logout action. Every tab requires core's **Administer
users** permission.

## How to use it

Pick the tab for the action you want, fill in the user, roles or confirmation
checkbox, and submit. The matching sessions are destroyed right away. See
[Configuration](configuration/index.md) for a field-by-field walkthrough of each
form, including which roles are always excluded.
