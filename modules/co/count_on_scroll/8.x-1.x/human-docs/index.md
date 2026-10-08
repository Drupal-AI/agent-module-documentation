# Count on Scroll — manual setup guide

**Count on Scroll** (`count_on_scroll`) is a field formatter for **integer**
fields that animates the number counting up — from zero to its stored value — the
moment the field scrolls into view. It's the familiar "animated statistics" effect:
"1,240 customers" ticking upward as the visitor reaches that part of the page.

It's a display‑only enhancement. The formatter changes only how the number is
*rendered*; the value stored in the field is untouched, and the module has no
role in access control or content. Use it on stat or number fields where an
animated count draws the eye — impact figures, member counts, project totals, and
the like.

The module works on Drupal 8.8, 9, 10, and 11, has no other module dependencies,
and no third‑party libraries to install. There is no central settings page — you
turn it on per field, on that field's display, where you can also set the
animation duration (see "How to use it").

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is set up entirely on a
field's *Manage display*, described below.

## Where it lives in the admin menu

Count on Scroll adds no admin page. You use it from **Structure → Content types
(or any fieldable entity) → *(bundle)* → Manage display**, where it appears as a
formatter option for integer fields.

## How to use it

1. Add a **Number (integer)** field to a content type or other entity type if you
   don't already have one.
2. Go to that entity type's **Manage display** tab.
3. For your integer field, choose **Count on Scroll** as the field's format.
4. Adjust the **duration** of the count‑up animation if you'd like, then save.

Now, when a visitor scrolls the field into view on the frontend, the number
animates from zero up to its value.
