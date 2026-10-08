# Views content moderation current state — manual setup guide

**Views content moderation current state** (`views_cm_current_state`) adds a single
Views field called **"Current state"** that shows the Content Moderation state of the
**latest** revision of each row's entity — including a not-yet-published draft that is
sitting ahead of the published version.

This fills a gap in core. Core's built-in "Moderation state" Views field reflects the
*default* (published) revision that a view loads for each row. So if an editor has a
published article and then saves a new **Draft** on top of it, core's field still
shows "Published" — it can't see the pending draft. This module's field loads each
entity's newest revision instead and shows *that* revision's moderation state, so your
listing tells the truth about what editors are actually working on. For content that
isn't under moderation at all, the field falls back to showing "Published" or
"Unpublished", so a mixed listing still renders a sensible status in the same column.

The field is computed at display time and adds nothing to the underlying database
query, so it is not sortable or filterable as a real column — it is purely for
showing the current state. It works in **any** view regardless of the view's base
table, because it is registered on Views' global table.

This guide is written for a **human** building a view in the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module adds no settings page and no menu items. It surfaces only as a Views field
you can add inside the **Views UI** (**Structure → Views**,
`/admin/structure/views`).

## How to use it

Once the module is enabled, add the field to any view:

1. Edit a view — for example the built-in content view at
   `/admin/structure/views/view/content`.
2. Under **Fields**, click **Add**.
3. Search for **Current state**. It is listed under the **Content revision** group,
   and it is offered on every view because it is attached to Views' global table.
4. Add it and click **Apply**. Give it a label such as "Current state" and **Save**
   the view.

The field has no special settings of its own beyond the standard Views field options
(label, rewrite results, exclude from display, and so on). It renders the newest
revision's moderation-state label when the view is displayed.

A few things to keep in mind:

- Both **Views** and **Content Moderation** must be enabled — they are hard
  dependencies of this module.
- Because the value reflects the **latest** revision (a pending draft), it can
  legitimately differ from core's "Moderation state" field in the same view. You can
  add both fields side by side to compare the default-revision state with the
  current-revision state.
- The field is not sortable or filterable — it is a display-only value computed from
  the loaded row entity.

Typical uses include an editors' dashboard of items whose latest revision is still in
"Draft", a "My drafts" view for authors, or a reviewer queue where the status column
reflects pending edits rather than the live published state.
