# Primary Entity Reference — manual setup guide

**Primary Entity Reference** (`primary_entity_reference`) is a custom **field type**
that extends Drupal's standard Entity Reference field with one extra idea: among the
several entities a field references, one of them can be marked as the **primary**.

It's for the common pattern where you reference multiple items but always need one
to be the "main" or "default" one — for example:

- setting one **address** as the primary address;
- highlighting the **lead author** among several contributors;
- marking the **featured image** out of a gallery;
- defining a **main contact** from a list of people.

The field enforces that exactly one referenced entity is always primary: if only one
value exists, it's treated as primary automatically. It ships with a **widget** for
choosing the primary item inline as you edit, and a **formatter** that displays only
the primary entity. It's fully compatible with Drupal's Field API (and integrates
with Inline Entity Form), so it behaves like a normal reference field everywhere
else. The references themselves respect entity access — this module adds no access of
its own. It's published under the **Field types** package.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no module settings page** — you configure this per field, on the field's
own settings, widget, and display. See "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On a content type (or any fieldable entity), add a new field and choose
   **Primary Entity Reference** as the field type. Configure which entity type and
   bundles it may reference, just as you would a normal entity reference field, and
   allow multiple values so there's something to pick a primary *from*.
3. On the form display (**Manage form display**), use the module's **widget** to let
   editors mark one referenced item as primary inline while editing. When there's
   only one value, it's automatically primary.
4. On the display (**Manage display**), if you only want to show the primary item,
   choose the module's **formatter** that renders only the primary entity. Otherwise
   render the field normally and use the primary designation in your own
   templates/logic.
