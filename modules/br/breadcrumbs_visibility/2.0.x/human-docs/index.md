# Breadcrumbs Visibility — manual setup guide

**Breadcrumbs Visibility** (`breadcrumbs_visibility`) gives editors a simple
on/off switch for the breadcrumb trail on individual nodes. Instead of writing
block visibility rules or custom PHP to hide breadcrumbs on a landing page, you
tick (or untick) a **Display breadcrumbs** checkbox right on the node edit form,
and the core breadcrumb block disappears from that page.

Under the hood the module adds a small boolean field, `display_breadcrumbs`, to
every node. It defaults to *on*, so nothing changes until you deliberately turn
breadcrumbs off somewhere. The field is revisionable and translatable, so a
node's breadcrumb choice is preserved across revisions and translations, and a
cloned node inherits the setting of the node it was copied from. You can also set
a **per-content-type default** on the content type edit form — for example,
default every "Campaign" page to *no breadcrumbs* while leaving articles
untouched.

Enforcement is deliberately narrow: the module only ever hides the core
`system_breadcrumb_block`, only on node pages, and only when the resolved value
is "off". Views pages, taxonomy pages, and every other block are left completely
alone. A dedicated permission, **Administer breadcrumbs visibility config**,
controls who is allowed to change the checkbox — users without it still see the
control, but it is greyed out and read-only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Breadcrumbs Visibility has **no settings page of its own**. Everything happens on
forms you already use:

- **Per node** — on the node edit form, open the **Page display options** group
  in the right-hand sidebar (next to *Authoring information*, *Menu settings*,
  etc.) and toggle **Display breadcrumbs**.
- **Per content type** — at **Structure → Content types → (your type) → Edit**
  (`/admin/structure/types/manage/<type>`), a **Page display defaults** section
  lets you set whether new nodes of that type show breadcrumbs by default. This
  default is stored in configuration (`breadcrumbs_visibility.content_type.<type>`)
  and only applies when an individual node hasn't been given its own value.
- **Permission** — grant **Administer breadcrumbs visibility config** at
  **People → Permissions** (`/admin/people/permissions`) to the roles allowed to
  change these toggles.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). On install it
   backfills every existing published node to "breadcrumbs on", so nothing
   visibly changes at first.
2. Decide who may change the setting: give the **Administer breadcrumbs
   visibility config** permission to your editor/administrator roles. Anyone
   without it sees the checkbox disabled with the note "Your account does not
   have permission to set the breadcrumb visibility."
3. To hide breadcrumbs on one page, edit the node, open **Page display options**,
   untick **Display breadcrumbs**, and save. The breadcrumb trail is gone on that
   node only.
4. To make "no breadcrumbs" the default for a whole content type, edit the
   content type and set the **Page display defaults** checkbox accordingly. New
   nodes of that type start from this default; editors can still override it
   per node.

Because the field is revisionable and translatable, each revision and each
translation remembers its own choice, and the module is deliberately ordered to
run after modules like Scheduler so scheduled publishing still respects the
setting.
