# Admin Audit Trail — manual setup guide

**Admin Audit Trail** (`admin_audit_trail`) keeps a log of the create, update,
and delete (CUD) actions people perform through your site's admin forms, and
shows them in a filterable report at **Reports → Audit trail**
(`/admin/reports/audit-trail`). It's the tool you reach for when you need to
answer "who changed what, and when?" — for editorial accountability, security
review, or a compliance audit trail (HIPAA, GDPR, SOC 2).

Each logged action is written to a dedicated `admin_audit_trail` database table
and captures the acting user, the operation, a human-readable description, the
client IP, the request path, and a timestamp. The report is a View with exposed
filters, so you can narrow it by event type, operation, user, IP address, or a
keyword.

The important thing to understand is that the **base module is just the
plumbing** — it logs almost nothing on its own. You get actual logging by
enabling one or more of the 16 `admin_audit_trail_*` submodules, one for each
subsystem you want tracked: nodes, users, taxonomy, menus, media, comments,
files, configuration, workflows, groups, paragraphs, redirects, entityqueue,
block content, user roles, and authentication. Each submodule registers an event
type and starts recording that subsystem's changes.

One caveat worth knowing: logging deliberately ignores command-line (CLI)
requests, so changes made through Drush are not recorded — only real web-form
submissions are.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   base module, and turn on the submodules for the subsystems you care about.
2. [Configuration](configuration/index.md) — the report, the settings form (row
   limit and filter display), permissions, and the full list of submodules.

## Where it lives in the admin menu

- **Report:** **Reports → Audit trail** (`/admin/reports/audit-trail`).
- **Settings:** **Configuration → Development → Audit Trail → Settings**
  (`/admin/config/development/audit-trail/settings`).

## How to use it

1. Install and enable the base module (see
   [Installation](installation/index.md)).
2. Enable a submodule for each subsystem you want tracked, for example
   `admin_audit_trail_node` and `admin_audit_trail_user`.
3. Grant the **Access admin audit trail** permission to the roles that should
   read the report.
4. Make some content or user changes through the admin UI, then open **Reports →
   Audit trail** and filter to find the events you're after.

On busy sites, set a row limit in the settings so the log table doesn't grow
without bound — see [Configuration](configuration/index.md).
