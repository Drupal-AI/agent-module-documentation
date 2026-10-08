# Login & Access Security (Session Management) — manual setup guide

**Login & Access Security** (machine name `session_management`) is a miniOrange module
that bundles several session and login controls in one place. It can limit how many
simultaneous sessions an account may have, automatically log out idle users, restrict
who may log in by IP address, keep login/logout reports, and give each user a "Sessions"
tab to review their own active logins. It's aimed at sites that need tighter account
security than core provides — membership sites, intranets, anything multi-user.

The features are built around Drupal's core `sessions` table and Views. Session limiting
is enforced on every authenticated request (the oldest session is dropped when a user
exceeds the limit); auto-logout is driven client-side with an "are you still there?"
modal; and IP restriction adds a validator to the login form using an allow-list that
understands CIDR blocks, ranges, and single IPs, for both IPv4 and IPv6.

Configuration is spread across several admin forms under *People → Login & Access
Security*, all gated by the core **Administer site configuration** permission — the
module defines no permissions of its own. It depends on core's **Views** module. Two
things to set expectations: much of the settings UI advertises **premium/paid** upsell
(trial, licensing, support), and in this free version the "Delete session" action on the
per-user sessions list is a premium feature that does nothing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the session-monitor, session-limit,
   auto-logout, and IP-restriction settings across the admin forms.

## Where it lives in the admin menu

The settings live under **Configuration → People → Login & Access Security**
(`/admin/config/people/session-management/…`), split across several forms — session
settings, auto-logout, login/IP settings, reports, and a modal-text form — all requiring
**Administer site configuration**. Each user also gets a **Sessions** tab on their own
account page (`/user/{user}/mo_sessions`), which only that account's owner can see (and
only while the session monitor is enabled).
