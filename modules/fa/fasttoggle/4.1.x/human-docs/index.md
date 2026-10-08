# Fasttoggle — manual setup guide

**Fasttoggle** (`fasttoggle`) adds one‑click toggle links for common boolean
settings — publishing/unpublishing a node, promoting or demoting it, marking it
sticky, and flipping the published status on comments — so editors can change
these without opening the full edit form. It uses AJAX callbacks, which saves a
lot of page loads.

The toggle links you see depend on two things: which toggles you have enabled on
each content type and comment type, and which roles hold the **Use Fasttoggle**
permission. The links appear next to an item's operation links only where the
toggle is enabled for that bundle and only for users who have that permission, so
it is worth confirming both match your moderation model.

It depends on core's **Node** and **Comment** modules, provides its own
permissions (**Administer Fasttoggle** and **Use Fasttoggle**), and has a small
settings form for choosing the label style used on the links.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the per‑bundle
   toggle checkboxes, and the permissions that control who sees the links.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Fasttoggle** (route
`fasttoggle.settings`). Which toggles are offered is set per bundle on each
content type's and comment type's edit form. Its permissions are managed on the
standard permissions page at **People → Permissions**
(`/admin/people/permissions`) — search for "fasttoggle". See
[Configuration](configuration/index.md) for details.

## How to use it

Once enabled, a toggle is turned on for a bundle, and a role has the **Use
Fasttoggle** permission, the toggle links appear next to the relevant item on
content and comment listings and pages. Click a link (for example *Unpublish*)
and Fasttoggle flips the setting in place via AJAX — no edit form, no full page
reload.
