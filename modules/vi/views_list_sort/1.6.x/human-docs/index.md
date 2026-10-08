# Views List Sort — manual setup guide

**Views List Sort** (`views_list_sort`) lets a View sort its results by a **List
(text)** field's *allowed‑values order* — the order in which you defined the
options in the field settings — instead of alphabetically. So a field with the
options `low`, `medium`, `high` sorts in that meaningful sequence rather than the
alphabetical `high`, `low`, `medium`.

It does this with a single Views **sort handler**. When you enable the module,
every List (text) field automatically gains the smarter sort option, so you don't
have to configure anything globally — you just add the field as a sort criterion
in a View and tick a box. Under the hood it orders rows by each value's position
in the field's defined list using a SQL `FIELD()` expression.

There is **no admin settings page** — everything is configured per‑View on the
sort criterion itself. This makes it a small, focused developer/site‑builder tool
rather than something with its own configuration screen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Views List Sort adds **no menu items and no settings page**. Its one feature
appears inside the Views UI, as extra options on the sort criterion for any List
(text) field.

## How to use it

You need a View that has a **List (text)** field available (for example a
`priority` field with options `low`/`medium`/`high`, or a `status` field with
`draft`/`review`/`published`).

1. Edit your View at **Structure → Views**.
2. In the **Sort criteria** section, click **Add** and choose your List (text)
   field, then apply.
3. On the sort settings that open, you'll now see two extra options provided by
   this module:
   - **Sort by allowed values** — set this to **Yes** to turn on allowed‑values
     ordering. (When it is *No*, the field sorts normally/alphabetically, so this
     is the switch that activates the feature.)
   - **Treat null values as heavier than the allowed values** — set to **Yes** to
     push rows with an empty/unset value to the end of the list.
4. Set the sort **order** (ascending or descending) as you normally would, then
   click **Apply** and **Save** the View.

Your results now follow the field's defined option order. This saves you from
having to re‑key your allowed values just to get the display order right, and it
combines cleanly with other sort criteria if you need a secondary sort.
