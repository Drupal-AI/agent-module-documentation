# Field Label Plurals — manual setup guide

**Field Label Plurals** (`field_label_plurals`) lets a multi-value field carry
*two* labels — one for the singular case and one for the plural — and shows the
grammatically correct form based on how many values the field currently holds. So
a field that lists authors can read "1 author" when there is a single value and
"3 authors" when there are several, instead of an awkward always-plural (or
always-singular) label.

It is a small, focused labeling helper. It changes only how a field's label
*renders* — it does not touch the stored data, and it has no effect on who can
see or edit a field. It depends only on Drupal core's **Field** module, and it
works on any field whose "Number of values" (cardinality) setting allows more
than one value.

There is no separate settings page. Once the module is enabled, an extra **"Label
to use for a single value"** text box appears on the field's edit form, right
below the standard **Label** field, whenever that field is configured to hold
multiple values. You fill in the singular wording there, and Drupal picks the
right form automatically at display time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module. You set the singular
and plural labels directly on each multi-value field, as described below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   Manage fields screen of any fieldable entity), and edit a field that is set to
   hold **more than one value**.
2. The usual **Label** text box now holds the *plural* wording (for example,
   "Authors").
3. Just below it you'll see a new **"Label to use for a single value"** box. Enter
   the *singular* wording there (for example, "Author").
4. Save the field. When the entity is displayed or edited, Drupal shows "Author"
   when the field has one value and "Authors" when it has several.

The singular box only appears on fields whose cardinality is greater than one — a
single-value field has nothing to pluralize, so there is nothing to configure.
