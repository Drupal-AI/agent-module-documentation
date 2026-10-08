# Debug Bar — manual setup guide

**Debug Bar** (`debug_bar`) adds a lightweight, floating toolbar to your pages
that surfaces useful debug information and links while you're developing. It's a
simple, at-a-glance aid for developers — an in-page bar rather than a full
profiler — and it has no external dependencies.

Viewing the bar is controlled by a **View debug bar** (`view debug bar`)
permission, and its administrative configuration by an **Administer debug bar**
(`administer debug bar`) permission. It lives in the **Development** package,
supports Drupal 10 and 11, and is actively maintained (in maintenance-fixes mode)
and covered by Drupal's security advisory policy.

> **Development only — do not expose broadly on production.** A debug toolbar can
> reveal runtime and internal information (routes, timings, configuration, and
> potentially sensitive data). Grant **View debug bar** only to trusted developer
> roles, and never expose it to anonymous or general authenticated users on a
> production site. The module has no access-control role of its own beyond these
> permissions — the permission grant *is* the control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the view permission to the right roles.

This module has no meaningful end-user settings form to document — the important
setup is the **permission grant** described below and in the installation guide.

## Where it lives and how to use it

Once enabled, the debug bar appears floating on the page for any user who holds the
**View debug bar** permission. To make it useful and safe:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant **View debug bar** only to your developer/administrator role(s).
3. Grant **Administer debug bar** to administrators who should manage the module.

Then browse the site as one of those users and the toolbar will be visible.
Because the bar can surface internal details, treat the view permission as
sensitive and keep it off untrusted roles — especially on production.
