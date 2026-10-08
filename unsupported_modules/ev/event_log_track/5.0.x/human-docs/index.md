<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events Log Track — manual setup guide

**Events Log Track** (`event_log_track`) keeps an audit trail of who did what on
your site. It records create, update, and delete events (and a few others, like
logins and 403s) into a dedicated `event_log_track` database table, and shows them
as a filterable admin report. It is the "who changed this, and when" tool for
compliance and troubleshooting.

The base module is the engine — the storage, the report, the settings form, and
the logging API. On its own it logs almost nothing. You turn on tracking for the
things you care about by enabling **submodules**, one per subsystem: nodes, users,
taxonomy, media, files, comments, menus, configuration changes, content-moderation
workflows, webforms, and more. Two extra submodules (**syslog** and **stdout**)
forward every event to an external log or SIEM instead of, or in addition to, the
database.

Each logged row records the event type and operation, a human-readable
description, references to the affected object, and the user, IP address, path,
and timestamp. From the report you can filter by type, operation, and user, and
you can build your own Views on the underlying table. Developers can add tracking
for custom entities or events through a handler hook — see the
[`agent/`](../agent/start.md) docs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the submodules for what you want to track.
2. [Configuration](configuration/index.md) — the settings form (log deletion,
   batch size, CLI logging, skip patterns) field by field.

## Where it lives in the admin menu

- The audit report is at **Reports → Events log track**
  (`/admin/reports/events-track`), gated by the **Access event log track**
  permission.
- The settings form is at **Configuration → System → Events Log Track**
  (`/admin/config/system/events-log-track`), which needs **Administer site
  configuration**.

## How to use it

1. Enable the base module and the submodule(s) for the subsystems you want to
   audit (see [Installation](installation/index.md)).
2. Perform some actions on the site (edit a node, change a user role).
3. Visit **Reports → Events log track** and filter by type, operation, or user.
4. Optionally tune retention and behavior on the settings form — see
   [Configuration](configuration/index.md).
