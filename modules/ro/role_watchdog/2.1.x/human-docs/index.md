# Role Watchdog — manual setup guide

**Role Watchdog** (`role_watchdog`) keeps an audit trail of user‑role changes. It
automatically records every time a role is added to or removed from an account —
whether that happens on the user's profile, from the people/user list, or when an
account is first created — so you always have a history of *who* granted or
revoked *which* role, and on *whom*.

Each change is stored as its own log record, and the module adds a per‑user "Role
history" tab plus a few bundled Views for browsing the whole log site‑wide. This
is exactly what you want for answering "how did this user become an admin?",
detecting accidental or unauthorized privilege escalation after the fact, or
satisfying a compliance requirement to track permission changes on a multi‑admin
site.

Logging works the moment you enable the module — there is nothing you *must*
configure. An optional settings form lets you also mirror each change into
Drupal's standard log (dblog/syslog), and set up **email notifications** so a
chosen address is alerted when roles change. The module defines its own audit
entity and two permissions.

> **Heads up on the default notify email.** The module installs with a
> placeholder notification address (`email@example.com`) already filled in. Because
> notifications send whenever that field is non‑empty, you should open the settings
> form and either set a real address or clear it — see
> [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the optional settings form: dblog
   mirroring, monitored roles, and email notifications.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Role Watchdog**
(`/admin/config/people/role_watchdog`), gated by the *Administer Role Watchdog*
permission. The collected log entity has a collection under **Structure → Role
Watchdog** (`/admin/structure/role_watchdog`), and each user account gains a
**Role history** tab.

> **Note on the entity screens.** The log entity's own add/view/manage routes
> under **Structure → Role Watchdog** check some permission names that this release
> doesn't actually declare, so in practice those screens are reachable only by the
> superuser (user 1) unless another module supplies those permissions. This is
> more restrictive than intended, not a security hole — the automatic logging and
> the bundled Views still work regardless.
