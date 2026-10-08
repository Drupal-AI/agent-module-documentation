# Entity Display Modes Listing — manual setup guide

**Entity Display Modes Listing** (`entity_display_modes_listing`) is a small
site‑building convenience that surfaces an entity type's **display modes as extra
operation links** in the admin listings. On a page like **Structure → Content
types**, expanding a content type's operations dropdown normally shows *Manage
fields*, *Manage form display*, *Manage display*, and so on. When a content type has
more than one active display mode, this module lists those individual modes right in
the operations menu — so you can jump straight to the one you want instead of
opening the default display and then hunting through the tab navigation.

It's a quality‑of‑life tool for builders who work with several form or view display
modes per bundle. There's nothing to configure: the extra operation links appear as
soon as the module is enabled. It adds only admin navigation links and has no content
or access role of its own.

Note this project is **not covered by the security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the operation links appear automatically once
the module is enabled.

## Where it lives in the admin menu

The module adds no page of its own. Its effect shows up on the entity listing pages,
such as **Structure → Content types** (`/admin/structure/types`): open a bundle's
operations dropdown, and any additional active form/display modes are listed there as
their own links, alongside the usual *Manage fields* / *Manage display* operations.
