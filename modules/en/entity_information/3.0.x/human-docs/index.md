# Entity Information — manual setup guide

**Entity Information** (`entity_information`) adds a new **Information** tab to
entities — an extra local task (alongside *View*, *Edit*, *Delete* and so on) that
gathers various kinds of detail about the entity into one place. The tab is filled
with "detail blocks," and several ready‑made blocks ship with the module so you get
useful information out of the box.

The real power of the module is that it is **pluggable**: developers can add their
own detail blocks by writing Entity Information plugins, so a site or a custom
module can surface exactly the metadata, related items, or computed information its
editors and administrators need on that tab. It is aimed at people who manage
content and want a consolidated overview beside each entity rather than hunting
across several screens.

This is a lightweight administration/UI module with no external dependencies; it
supports Drupal 10 and 11. Enabling it adds the Information tab and its bundled
detail blocks; extending it with new blocks is a developer task.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no central settings form for this module. The Information tab appears on
entities automatically once the module is enabled, and its contents are determined
by the detail‑block plugins present (the bundled ones plus any a developer adds).

## How to use it

Once enabled, open any supported entity and look for the **Information** tab among
its local tasks. The tab shows the detail blocks that apply to that entity. To add
your own information to the tab, a developer creates an Entity Information plugin —
see the sibling [`agent/`](../agent/start.md) docs for the developer‑facing
details.
