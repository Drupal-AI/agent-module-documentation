# Entity Notes — manual setup guide

**Entity Notes** (`entity_notes`) lets you add **notes to any entity** on the
site — internal annotations, editorial comments, or reminders that live alongside
the content but aren't part of the public output. A note is a simple, general way
for one person or a team to record information about an object directly on the
website: think "needs legal review", "update after launch", an admin note on a
user account, or a note attached to a Drupal Commerce order.

What makes it flexible is that **notes are fieldable** and **displayed through
Views**. Because each note is an entity with fields, you can add whatever fields
your process needs; and because notes render through a View, you can theme and
arrange them however you like. Permissions are configurable per note, so you decide
who can add and who can read them. Typical uses are admin notes on user accounts,
notes on commerce orders, and general information notes on nodes.

Entity Notes depends on Drupal core's **Views** and runs on Drupal 9, 10, and 11.
It provides its own permissions. Since notes are internal information — they may
contain sensitive remarks that shouldn't leak to the public or to unauthorized
editors — gate who can view and add them with those permissions, and confirm notes
aren't accidentally exposed on a public display.

> **Important:** the Entity Note views ship with three required **contextual
> filters** — *Note: Entity Type*, *Note: Bundle*, and *Note: Entity ID* — that
> must remain present and **in that order**. Do not remove or reorder them, or the
> notes will not display correctly against their entities.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Views
   dependency, then enable it.

Configuration of *which* notes exist and *who* can use them is handled through
Drupal's field UI, Views, and the Permissions page rather than a single settings
form — see "How to use it" below.

## Where it lives in the admin menu

Entity Notes surfaces notes on the entities they refer to and manages their display
through **Views**. Permissions are set on **People → Permissions**, and any extra
note fields are managed through the field UI.

## How to use it

1. On **People → Permissions**, grant the note view/add permissions only to the
   roles that should use them — remember notes are internal.
2. Add any fields your notes need through the field UI (notes are fieldable).
3. Attach notes to the entities you care about — user accounts, commerce orders,
   nodes, and so on — and confirm they appear where you expect.
4. If you customize the Entity Note views, **keep the three contextual filters**
   (Entity Type, Bundle, Entity ID) present and in order.
5. Verify that notes are not exposed on any public-facing display.
