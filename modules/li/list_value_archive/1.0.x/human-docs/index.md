# List Value Archive — manual setup guide

**List Value Archive** (`list_value_archive`) solves a small but persistent
annoyance with Drupal's List fields (List text, List integer, List float). Those
fields store a fixed set of allowed values, and once a value is used by any
content, core refuses to let you remove it — so retired options linger in every
dropdown, radio set, and checkbox list forever.

This module lets you **archive** an individual value instead of deleting it. An
archived value is hidden when editors create new content, but it stays valid for
existing content, which continues to display, validate, and save normally. There's
no migration and no data loss, and you can re‑enable an archived value at any time
with a single click.

Archiving is done right on the normal List field edit form — there's no separate
configuration page. The archived state is stored as field configuration, so it's
fully exportable and deployable like any other field setting. Access is controlled
by a dedicated permission, **Archive List field values**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page**. The archive setting lives on each
individual List field, described in "How to use it" below. Just remember to grant
the **Archive List field values** permission to the roles that manage fields.

## Where it lives in the admin menu

List Value Archive adds no admin page of its own. You use it from **Structure →
Content types (or any fieldable entity) → *(bundle)* → Manage fields**, on the
edit form of each List field.

## How to use it

1. Grant the **Archive List field values** permission to the appropriate roles at
   **People → Permissions** (`/admin/people/permissions`) — typically your site
   builder or administrator roles.
2. Go to **Manage fields** for the bundle and edit the List field whose options
   you want to prune.
3. On the field edit form you'll find an **Archived values** section listing the
   field's allowed values. Tick the values you want to archive.
4. Save the field. The archived values disappear from select lists, radio buttons,
   and checkboxes for new content, while existing content that already uses them
   keeps rendering, validating, and saving.
5. To bring a value back, edit the field again and untick it under **Archived
   values**.
