# Better User Accounts — manual setup guide

**Better User Accounts** (`better_user_accounts`) is a collection of
improvements to Drupal's user-account UI and management — refinements to the
account edit/view experience and to how administrators manage users. It depends
only on core's User module and lives in the User interface package.

The module provides its own permissions to control who gets its enhancements,
but it adds no access-control role beyond that: it works within core's existing
user access (edit/administer users). There is no dedicated settings form to
configure.

Note this is an **alpha** release (1.0.0-alpha2), so treat it as early software
and test it before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant its permissions.

## How to use it

Once enabled, the account improvements apply to the standard user screens: the
people/account admin at **Administration → People** (`/admin/people`) and the
individual account edit/view pages under **My account** and `/user/{id}/edit`.
There is no separate configuration page — the enhancements are part of those
existing screens.

Grant the module's permission(s) at **People → Permissions**
(`/admin/people/permissions`) to the roles you want to receive its
improvements. Because it works within core user access, users still need the
usual core permissions (such as *Administer users*) to manage accounts.
