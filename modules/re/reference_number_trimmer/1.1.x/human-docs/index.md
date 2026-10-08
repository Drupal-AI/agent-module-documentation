# Reference Number Trimmer — manual setup guide

**Reference Number Trimmer** (`reference_number_trimmer`) hides the entity **ID
number** that Drupal's default autocomplete reference widgets show. When you use a
standard entity-reference autocomplete field, the selected value normally appears
as *Article title (42)* — with the numeric entity ID in parentheses. For content
editors that trailing number is often confusing or simply unwanted, and this
module removes it so the field shows just the clean label.

It works by adding new **autocomplete widgets** — the same as core's, but with
"hidden IDs" in the name. You switch a reference field over to one of these
widgets on the bundle's **Manage form display** page, and the ID disappears from
the input while everything else about the field behaves as before.

The module is deliberately lightweight and keeps as much of Drupal's default
behavior as possible. It relies on a little client-side JavaScript to hide the ID;
if a visitor has JavaScript disabled, the field gracefully falls back to the
normal autocomplete with the ID visible. It is a stop-gap for a
[core issue](https://www.drupal.org/project/drupal/issues/2881892) and is
considered feature-complete.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
switch a field to a "hidden IDs" widget on its Manage form display, described in
"How to use it" below.

## Where it lives in the admin menu

Reference Number Trimmer adds no admin page of its own. You use it from
**Structure → Content types (or any entity bundle) → Manage form display**, where
the new "hidden IDs" autocomplete widgets appear for reference fields.

## How to use it

1. Go to the bundle whose reference field you want to clean up — for example
   **Structure → Content types → Article → Manage form display**.
2. Find the entity-reference field in the list.
3. In its **Widget** column, choose the autocomplete widget with **"hidden IDs"**
   in its name (there is a hidden-IDs version of the standard autocomplete and of
   the tags-style autocomplete).
4. Click **Save**.

From then on, editors filling in that field see the referenced entity's label
without the trailing `(42)` ID number. Because the trimming is done in the
browser, users with JavaScript turned off still get the normal, fully functional
autocomplete widget — just with the ID shown.
