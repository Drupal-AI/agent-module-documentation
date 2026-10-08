# Contacts — manual setup guide

**Contacts** (`contacts`) is a **CRM toolkit for Drupal**. It manages people and
organisations as *decoupled users* plus *profiles*, and presents them through a
configurable, tabbed **Contacts dashboard** backed by Search API. Rather than a
single small feature, it's a small distribution's worth of machinery — expect to
install a stack of dependencies and think of it as the foundation of a contact‑
management or membership system, not a drop‑in widget.

At its heart, contacts belong to CRM roles — individuals (`crm_indiv`),
organisations (`crm_org`), and managers (`crm_manager`) — and are described by
profile bundles (individual, organisation, notes). The dashboard at
`/admin/contacts` is assembled from configurable *tabs* and *layout blocks*, which
administrators can rearrange in a "manage mode". A Search API database index powers
listing, filtering with facets, and duplicate detection. Because it leans on
decoupled authentication, a "contact" doesn't have to be a login account — it can be
a pure record — which is what makes it a real CRM rather than just a fancy user
list.

Several **submodules** extend it: `crm_tools` (advanced roles plus a unified
login/register page — this one is bundled and enabled with the base module),
`contacts_user_dashboard` (a front‑end `/user/{user}/summary` account dashboard),
`contacts_log` (activity logging via the Message module), `contacts_group` (Group
integration), `contacts_dbs` (a DBS status workflow), and `contacts_mapping`
(showing contacts on a geolocation map). Access is permission‑gated throughout —
there are no anonymous contact‑data endpoints — though note that the `view contacts`
permission is deliberately **CRM‑wide** (a holder can view *any* contact), which is
by design for a back‑office CRM rather than a per‑record restriction.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the CRM dependency stack with
   Composer, enable Contacts, and pick the submodules you need.
2. [Configuration](configuration/index.md) — permissions, the dashboard, tabs and
   blocks, and the basic settings form.

## Where it lives in the admin menu

- The **Contacts dashboard** is at **`/admin/contacts`** (with individuals‑only and
  organisations‑only variants, and a per‑contact view at
  `/admin/contacts/{user}/{subpage}`).
- Add contacts at **`/admin/contacts/add/indiv`** and **`/admin/contacts/add/org`**.
- **Basic settings** live at **`/admin/config/contacts`** (route
  `contacts.basic_config`).
