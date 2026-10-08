# Citation Style Language (Islandora) — manual setup guide

**Citation Style Language (Islandora)** (`islandora_csl`) generates scholarly
**citations** for [Islandora](https://www.islandora.ca/) repository objects. It
turns an object's metadata into a formatted citation using the
[Citation Style Language](https://citationstyles.org/) (CSL) — the same standard
Zotero and Mendeley use — so academic and library repositories can show a ready-made
reference for each item.

It works by adding a **pseudo-field, `field_islandora_csl`**, to nodes of the
`islandora_object` type. That field renders a citation built from the fields present
on the object; out of the box it produces an **MLA** citation from the available
Islandora metadata.

It depends on the **Islandora** and **Controlled Access Terms** modules, so it only
makes sense on an Islandora site whose objects carry the usual descriptive metadata.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings form** for this module. You surface the citation by
placing its pseudo-field on your object's display, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin configuration page. You work with it on your
`islandora_object` content type under **Structure → Content types → Islandora Object
→ Manage display**, where the **`field_islandora_csl`** pseudo-field appears.

## How to use it

1. Go to the **Manage display** tab of your `islandora_object` content type
   (`/admin/structure/types/manage/islandora_object/display`).
2. Find the **`field_islandora_csl`** pseudo-field and drag it out of *Disabled* into
   a visible region, then arrange where you want the citation to appear.
3. Save. When you view an Islandora object, the citation is generated from its
   metadata and rendered in that position.
