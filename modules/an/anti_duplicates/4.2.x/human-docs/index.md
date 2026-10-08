# Anti-Duplicates — manual setup guide

**Anti-Duplicates** (`anti_duplicates`) helps you keep duplicate content off your
site. When someone creates a node that duplicates existing content — by title, or
by other criteria you configure — the module can **warn** the author or **block**
the submission outright. It is aimed at the everyday problem of accidental
duplicates: double‑submitted forms, re‑entered listings, or imported content that
overlaps what is already there.

It works at the point a node is submitted, enforcing the uniqueness rules you set.
It is a content‑integrity feature: it depends on core's **Node** module, provides
its own permissions, and has no access‑control role of its own.

You decide, on the module's admin page, which fields or criteria define a
"duplicate" and whether a match should merely warn or actually prevent the save —
so you can tune it per the content types where duplicates are actually a problem.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the duplicate criteria and choose
   warn versus block.

## Where it lives in the admin menu

The module's settings are on its own admin page (route
`anti_duplicates.admin_page`). Grant its permissions under **People → Permissions**
to the roles that should manage duplicate‑detection settings.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On the admin page, choose which fields/criteria define a duplicate and whether
   to warn or block (see [Configuration](configuration/index.md)).
3. From then on, submissions that match your rules are flagged or prevented.
