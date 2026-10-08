# Entity UUID Lookup — manual setup guide

**Entity UUID Lookup** (`entity_uuid_lookup`) solves a small but recurring
developer and support headache: someone hands you an entity's **UUID** — from a
log, an API payload, a config export — but you have no idea which node, term, or
user it belongs to or where to find it. This module gives you an admin form (and
a matching admin toolbar button and menu link) where you paste a UUID and get
redirected straight to that entity's canonical or edit URL.

It is purely an administrative convenience. It has no dependencies, adds no
content, and does not change how anything is displayed. The redirect it performs
still respects normal entity access, so it does not hand out access to anything a
user could not otherwise reach — but the lookup form itself should be limited to
trusted administrators via its permission.

Two permissions control who sees and uses the tool: **Lookup entities by UUID**
and core's **View the administration theme**. Grant both to the roles that need
it, and the toolbar button and admin menu link appear for those users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the two permissions that reveal the tool.

There is **no settings page** for this module — the only "form" is the lookup box
itself, described below.

## How to use it

1. Grant a trusted role both **Lookup entities by UUID** and **View the
   administration theme** at **People → Permissions**
   (`/admin/people/permissions`).
2. As a user with those permissions, click the **UUID lookup** button in the
   admin toolbar (or follow its admin menu link).
3. Paste an entity's UUID into the form and submit. You are redirected to that
   entity's canonical or edit URL. Normal entity access still applies to the
   destination.

> A related project, **Find UUID**, offers a Drush command and JSON API for the
> same job if you need it outside the UI.
