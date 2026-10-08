# Role Expire — manual setup guide

**Role Expire** (`role_expire`) makes user roles time-limited. Any role a user
holds can be given an expiration date and time; when that moment passes, a cron
run removes the role automatically — and can optionally swap in a different role
in its place. It turns "premium members", "trial editors", "beta testers" and
similar temporary access into something that cleans itself up, with no manual
role edits.

You control expiry in two places. On a **role's** edit form you can set a
**default duration** (like `1 year` or `3 months`), so every user newly granted
that role automatically expires after that span. On a **user's** edit form, each
expiration-enabled role the user holds gets its own **Role expiration** field,
where you can enter an absolute date (`YYYY-MM-DD HH:MM:SS`) or a relative phrase
(`1 day`, `2 weeks`). A settings page ties it together: which roles participate
in expiration, their default durations, and which role (if any) to assign when
one expires.

When a role expires on cron, Role Expire removes it, optionally grants the
configured replacement role, and fires an event so other code (or the optional
Rules submodule) can react. Everything is also reachable programmatically through
the `role_expire.api` service, and the module exposes Views fields so you can
report on upcoming expirations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the Rules submodule.
2. [Configuration](configuration/index.md) — the settings form, per-role default
   durations, per-user expiry dates, permissions, and replacement roles.

## Where it lives in the admin menu

The main settings form is at **Configuration → People → Role Expire**
(`/admin/config/people/role-expire`). Per-role default durations are set on each
role at **People → Roles → Edit** (`/admin/people/roles/manage/<role>`), and
per-user expiry dates appear on each user's edit form (`/user/<id>/edit`).

## How to use it

A common setup: open the settings form, make sure the roles you want to time-box
are enabled for expiration, and give any "auto-expiring" role a default duration.
Then when you grant that role to a user — or set an explicit date on their user
edit form — the expiry is recorded. Cron does the rest: once the date passes, the
role is removed (and the replacement role, if you configured one, is added). See
[Configuration](configuration/index.md) for the details of each field.
