# ELI Permalinks — manual setup guide

**ELI Permalinks** (`eli_permalinks`) lets a Drupal site create, publish, and
manage persistent URLs based on the **European Legislation Identifier (ELI)**
model — the standard, technology‑neutral way of citing legislation with a stable
URI. Each permalink lives at a path like
`/eli/{jurisdiction}/{type}/{year}/{month}/{day}/{number}/…` and always resolves
to the current destination you point it at, so a citation never breaks even when
the underlying document moves.

An administrator creates ELI permalink records and gives each one a destination:
either a **redirect to an external URL** or an **attached, Drupal‑managed file**
(the two are mutually exclusive). When a visitor requests the ELI path, the module
either issues a browser redirect to the configured URL or streams the attached
file inline — and either way emits a `rel="canonical"` link header. The public
resolver is intentionally open (ELI URIs are meant to be openly citable), but it
only ever exposes destinations an administrator explicitly configured on a
**published** permalink, so there is no arbitrary redirect or file exposure.

The module ships pluggable **jurisdiction profiles** that encode how ELI path
components map together — a **Spain** profile and a **European Union** profile
come built in, and developers can add more. It relies only on Drupal core's
**File** and **Options** modules; no contributed modules are required.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

This module has **no settings form** — you work with it through its
create/edit/delete admin interface, described in "How to use it" below.

## Where it lives in the admin menu

Once enabled, the permalink manager sits at **Administration → Content → ELI
Permalinks**. You need the **Administer ELI permalinks** permission to reach it.

## How to use it

1. Grant the **Administer ELI permalinks** permission to the roles that should
   manage permalinks (**People → Permissions**).
2. Go to **Content → ELI Permalinks** to see the list of permalinks, with actions
   to create, edit, enable, disable, and delete.
3. To create one, choose the jurisdiction profile (for example Spain or the
   European Union), fill in the ELI path components, and set **one** destination:
   either an external URL to redirect to, or a managed file to serve. The module
   enforces that the two destinations are mutually exclusive and that each ELI
   path is unique.
4. Only **published** permalinks resolve publicly, so use the enable/disable
   actions to control which ones are live.

Once saved and enabled, requesting the permalink's `/eli/…` path resolves to your
chosen destination.
