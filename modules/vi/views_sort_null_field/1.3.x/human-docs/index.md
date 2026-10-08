# Views Sort Null Field — manual setup guide

**Views Sort Null Field** (`views_sort_null_field`) fixes a common Views
annoyance: when you sort a listing ascending by a field, the rows whose field is
*empty* float to the top, because SQL treats an empty (NULL) value as the lowest
possible value. This module adds a Views sort handler that lets you decide where
empty values go — pushing them to the **bottom** of the list (or the top) instead
of wherever the database happens to put them.

It does this without any configuration screen, permissions, or stored settings. On
install it exposes an extra "… null sort" sort for every field column that is
allowed to be empty. You add that sort in the Views UI just like any other sort:
choose **ascending** to send empty values *last*, or **descending** to send them
*first*. Under the hood it simply orders rows by "is this field empty, yes or no",
so all the populated rows group together and all the empty ones group together.

Because the null sort only *buckets* empty versus non-empty, the usual recipe is to
add **two** sorts: the null sort first (to separate empties from non-empties), then
your normal field sort (to order the rows within each group). The result is exactly
what people usually want: "populated rows, properly sorted, with the empty ones at
the end."

This guide is written for a **human** building views in the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is **no settings page**. The module's only footprint is inside the **Views
UI**: when you edit a view (*Structure → Views*, `/admin/structure/views`) and add
a sort criterion, you'll see an extra "… null sort" option for each nullable field.

## How to use it

1. Edit a view at *Structure → Views* and open the display you want to sort.
2. In the **Sort criteria** section, click **Add**.
3. Find your field's **"null sort"** entry — for an integer field called
   `field_weight` on content, for example, it appears as something like
   *"Weight (field_weight) null sort"*. Add it.
4. On the configuration screen, choose the order:
   - **Sort NULL last** (ascending) — empty values go to the **bottom**.
   - **Sort NULL first** (descending) — empty values go to the **top**.
5. Add your **normal field sort** as a *second* sort criterion below the null sort,
   ordered however you like (e.g. ascending). This orders the rows *within* each
   bucket.
6. Save the view.

A typical example: a product list sorted by price, ascending, but with the
"no price yet" items kept at the very bottom instead of jumping to the top. Or an
events list where events with no date sink to the end. You can also flip it
(descending / *NULL first*) to surface records that are *missing* a value — handy
for a data-cleanup or "still needs entry" admin view.

The null sort works with exposed sorts too, so even when a visitor clicks a column
header to re-sort, the empty values still land where you told them to.
