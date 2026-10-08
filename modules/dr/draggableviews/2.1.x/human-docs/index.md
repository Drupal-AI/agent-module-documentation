# DraggableViews — manual setup guide

**DraggableViews** (`draggableviews`) makes the rows of a View draggable, so
editors can put content into a deliberate manual order by dragging rows up and
down and clicking **Save order**. It is the go-to solution whenever "sort by date"
or "sort by title" is not enough and someone needs to hand-curate a list — a
featured-content block, a team roster, a gallery sequence, a homepage promo order,
and so on.

It works by adding two handlers to Views: a field called **Draggableviews:
Content** (which renders the drag handles and the weight form) and a sort called
**Draggableviews: Weight** (which reads that saved order back). When both are on a
table display, rows become draggable and a **Save order** button appears; saving
writes each entity's weight to the module's `draggableviews_structure` database
table. Because the stored order is keyed by view name, display, and any contextual
arguments, the same content can carry *different* manual orders in different views,
and a public page display can read the order set on a separate admin "sort"
display. It also supports parent/child hierarchy with indented rows.

DraggableViews depends only on core's **Views** module and works with any entity
type Views can list — nodes, media, users, taxonomy terms, or custom entities. It
adds one permission, `access draggableviews`, which controls who may re-order and
save. There are no other services to call; ordering happens through the Views
field and its submit handler. An optional **DraggableViews Demo**
(`draggableviews_demo`) submodule ships example views you can learn from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus the optional demo submodule).

## Where it lives in the admin menu

DraggableViews has **no settings page of its own**. You configure it inside a View
at **Structure → Views** (`/admin/structure/views`), by adding its field and sort
to a display. It also adds one permission at **People → Permissions**
(`/admin/people/permissions`): **Access Draggableviews** (`access draggableviews`),
which decides who sees the **Save order** button and may persist a new order.
Grant it to trusted editors and moderators.

## How to use it

Set up a draggable, sortable view like this:

1. Create a View of your content (Content, Media, Users, and so on) and set the
   display **Format** to **Table**.
2. Add the field **Draggableviews: Content** to the display editors will drag on.
   If the view has several displays, add it to that one display only (override).
3. Add the sort criterion **Draggableviews: Weight** (ascending) and make it the
   *first* sort — remove or demote any default date/title sorts so the manual
   order wins.
4. In the sort's settings, the "Display sort as" option points at the view and
   display that *stores* the order. This is what lets a page display and a block
   display share (or deliberately not share) the same manual order.
5. Save the View. The table rows now show drag handles, and a **Save order** button
   appears for any user who has the `access draggableviews` permission.

Editors drag rows into the desired order and click **Save order**; the new weights
are written to the `draggableviews_structure` table and the relevant list caches
are cleared, so the order updates everywhere it is displayed. To show that order to
visitors, add the **Draggableviews: Weight** sort to your public page or block
display as well.

Ordering is stored per contextual-argument value, so a view that takes an argument
(for example a category) can hold an independent manual order for each argument.
For migrations, the module also provides a `draggableviews` migrate destination
plugin that can import a pre-existing manual order straight into the structure
table.
