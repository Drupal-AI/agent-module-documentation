# Entity Recycle — manual setup guide

**Entity Recycle** (`entity_recycle`) gives your site a **recycle bin (trash)**
for content. Instead of permanently removing an entity when someone deletes it,
the module **soft‑deletes** it — the content is hidden from normal listings but
kept, so it can be **restored** later. It is a safety net against accidental (or
malicious) deletion.

Under the hood the module adds a locked boolean field (`recycle_bin`) to
entities; when that field is `TRUE`, the entity is considered "in the bin." Only
users with the right permission can see the recycle bin, and only trusted users
can **restore** items or **permanently delete** them. It can also **purge** items
automatically after they have sat in the bin for a set amount of time. A
"Content Recycle Bin" view is provided as a starting point for listing trashed
content.

The module works as soon as you enable it, but there are two things you should
review. First, grant the recycle‑bin permissions deliberately — restore and
permanent‑delete are powerful and should go to trusted roles only. Second, be
aware of a data‑retention implication: because the bin **retains "deleted"
content**, something a user believes is gone still exists on the site. For
data‑retention or erasure requests, make sure content is genuinely purged when
required. Entity Recycle depends only on core's **Node** module and supports
Drupal 10.1 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the recycle‑bin behaviour
   (retention/purge), permissions, and the note about hiding trashed items from
   your Views.

## Where it lives in the admin menu

Once enabled, the module adds a recycle‑bin listing (the "Content Recycle Bin"
view) that users with the **view entity recycle bin** permission can reach, plus
its behaviour and permission settings. Permissions are managed on the standard
**People → Permissions** page (`/admin/people/permissions`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Grant the recycle‑bin permissions to the appropriate roles (see
   [Configuration](configuration/index.md)).
3. When an editor deletes eligible content, it is moved to the recycle bin rather
   than removed.
4. A user with the **view entity recycle bin** permission opens the recycle bin,
   and can **restore** an item back to normal or **permanently delete** it if
   they have that permission.
5. Optionally, configure automatic purging so items older than a chosen age are
   cleared from the bin.
