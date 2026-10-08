# Permissions List (View Only) — manual setup guide

**Permissions List (View Only)** (`permissions_view_only`) gives you a
**read‑only** version of Drupal's familiar permissions‑per‑role grid. It shows
exactly the same matrix you see on the core *Permissions* page — every
permission down the side, every role across the top — but with all the editing
removed. Checkboxes become simple checkmark indicators (✓) for the permissions a
role has been granted, and there is no *Save* button, so nobody can change a
grant by accident from this screen.

The point is safe inspection. Auditors, content managers, support staff, and
other stakeholders often need to *see* who can do what without being trusted (or
wanting the responsibility) to alter the site's security settings. This module
lets you grant those people a single dedicated permission that opens the
view‑only grid, while the real, editable permissions page stays locked behind
the powerful *Administer permissions* right.

It builds directly on the **Filter Permissions** (`filter_perms`) module, which
it requires, so you also inherit that module's search/filter controls — you can
narrow the long permissions list by keyword or module while you review it,
without any editing rights. Once enabled, the module adds a new tab in the
People area alongside the existing *Permissions* tab (for users who are allowed
to see it). There is nothing else to build.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Filter
   Permissions dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — grant the view‑only permission to
   the right roles and understand what the page shows.

## Where it lives in the admin menu

The module adds no configuration page of its own. After you enable it and grant
the permission, a view‑only permissions grid appears as a local task (tab) in the
**People** area (`/admin/people`), next to the standard *Permissions* tab. Users
who hold the new permission — but not *Administer permissions* — will see only the
read‑only tab.
