# Permissions Grid — manual setup guide

**Permissions Grid** (`permission_grid`) offers an alternative way to administer
permissions. Instead of one long flat list, it shows a related *set* of
permissions as a grid of "verbs" across the top and "objects" down the side. For
node permissions, for example, the verbs are actions like *create*, *edit own*
and *delete any* along the columns, and the content types run down the rows —
so the whole permission matrix for that entity type is visible at a glance.

It is the successor to the old Node permissions grid module, now extended to any
module that declares structured permissions. Out of the box it understands
**Node**, **Taxonomy** and **Media** permissions.

This is a review-and-administration aid. The grid is a view onto your existing
permission assignments — it reveals your site's access model in a compact form,
so treat the page as sensitive and keep it to trusted administrators. It does
not add any new capability to the site beyond presenting permissions
differently.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate settings form** for this module — it simply adds grid
views for the permission sets it supports.

## How to use it

Once enabled, the module provides grid-style permission pages for the supported
entity types (Node, Taxonomy, Media). Open the permission grid for the entity
type you want to review, and use the verbs-across / objects-down layout to see
and adjust which roles hold which related permissions. Because editing here
changes real permissions, review the resulting role afterwards — as you would on
the standard permissions page.
