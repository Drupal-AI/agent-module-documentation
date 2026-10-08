# Sites group — manual setup guide

**Sites group** (`sites_group`) lets you run several websites from one Drupal
install by treating each **Group** entity as a distinct "site." It bridges the
**Group** module and the **Sites** module, so a Group becomes a site with its own
scoped content and access — an alternative to the Domain module that leverages
Group's spaces instead of hostnames alone.

The problem it solves is separating content and editorial work across sites
without standing up separate installs. Content creators work inside their own
Group/space, and the module ties that Group to a site context so content stays
where it belongs. It does this by providing a **Site plugin per configured Group**
and a context provider (`GroupFromSiteContext`) that resolves the current Group
from the active site, plus a service (`SitesGroupService`) that connects content to
its owning Group/site. It also **decorates Group's relation access‑control
handler** to enforce that group relations are edited on their canonical site, so a
relation is not edited from the wrong site context.

Setup happens through the **Group UI**, not a dedicated settings form: you create a
Group type, switch on the "sites group" behaviour for that type via its edit
dialog (this toggle is added by the `form_decorator` integration), create your
Groups, and then grant the needed view permissions on the Group type's Permissions
tab. It depends on the **Group** module and **Form Decorator**, with Group Node
(`gnode`) optional if you want to relate nodes to Groups. It supports Drupal 10 and
11.

Because access is layered on top of Group's own permission system, **review the
Group type permissions carefully** so content is not accidentally exposed across
sites — the canonical‑site access decorator tightens editing, but the base
visibility is still governed by Group's permissions. This is an early‑stage release
(1.0.0‑alpha2), and its own README notes there is install/deploy code still to be
cleaned up, so test thoroughly before relying on it.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with Group and Form Decorator).

## How to use it

There is no dedicated admin settings form — setup runs through the Group UI:

1. Enable **Group Node** (`gnode`) if you want to relate nodes to Groups.
2. Create a Group type (for example a "Custom sites" type) at
   **`/admin/group/types`**.
3. On the Group type's edit dialog, switch on the **"sites group"** behaviour.
4. Create at least one Group at **`/admin/group`** to represent a site.
5. On the Group type's **Permissions** tab, grant the view permissions each role
   needs — reviewing them carefully so content is not shared across sites.

In code, use `SitesGroupService` to connect an entity to its site, and the
`current_site`‑derived Group context to make blocks and plugins site‑aware.
