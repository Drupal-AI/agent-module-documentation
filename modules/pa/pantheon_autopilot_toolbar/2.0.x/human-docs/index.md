# Pantheon Autopilot Toolbar — manual setup guide

**Pantheon Autopilot Toolbar** (`pantheon_autopilot_toolbar`) is a small
convenience module for **Pantheon-hosted** Drupal sites. It adds a button to the
admin **Toolbar** that links directly to *this site's* **Autopilot status** page
on the Pantheon dashboard. Autopilot is Pantheon's automated update and
visual-regression service; its icon in the Pantheon dashboard normally points at a
workspace-wide overview that only Workspace-account users can reach, so this module
gives site-team members a direct jump to the per-site status URL from inside
Drupal.

It is exactly as simple as it sounds — as the maintainer puts it, a module that
will hopefully be unnecessary one day. The link is built from a Pantheon
environment variable, so it only makes sense on Pantheon. The module does **not**
know whether the current user actually has access to that Pantheon page, or even
whether Autopilot is configured for the site; Pantheon's dashboard enforces its own
access when the link is followed. The module's only access role is a **permission**
that gates who sees the toolbar button. It supports a wide range of core versions
(`^8` through `^11`); this release is `2.0.0-beta1`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

There is **no settings form** — the only thing to configure is the permission that
controls who sees the button, covered below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)) on a
   Pantheon-hosted site.
2. At **People → Permissions** (`/admin/people/permissions`), grant the module's
   permission to the roles whose members should see the Autopilot button.
3. Those users will now see an **Autopilot** icon in the admin toolbar; clicking it
   opens the site's Autopilot status on the Pantheon dashboard (which enforces its
   own access).

> **Note:** Because the link uses a Pantheon environment variable, the button only
> works on Pantheon. On a local or non-Pantheon environment the link will not point
> anywhere useful.
