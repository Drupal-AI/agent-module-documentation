# Link Selection Handler — manual setup guide

**Link Selection Handler** (`link_selection_handler`) provides a link‑field
**widget** that gives you control over the autocomplete results editors see when
they search for an internal link. By default, Drupal's link‑field widget uses a
hard‑coded entity autocomplete, which makes it hard to tell apart nodes that share
the same title. This module lets a link widget use **Entity Reference selection
handlers** — such as the Views‑based handler — so you can shape and filter what
appears in the autocomplete.

In practice this means you can constrain link fields to a curated set of internal
targets and present richer, more distinguishable autocomplete results, much like
configuring an Entity Reference field's selection settings. It depends only on
core **Link**.

Two limitations are worth knowing up front. First, there is a known issue where
the reference‑method settings may not save on the first pass — the workaround is
to press **Update**, then re‑open the widget's **Edit** and configure the
reference‑method settings again (this can also be handled by editing and
re‑importing the field's configuration YAML). Second, because this is its own
field widget, you cannot combine it in the same form display with other modules
that provide alternative link widgets, such as Link Attributes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no central settings page** for this module. You configure the selection
handler per field on **Manage form display**, described below.

## Where it lives in the admin menu

The module adds no admin page. You configure it from **Structure → Content types →
*(your type)* → Manage form display**, choosing the widget for a link field.

## How to use it

1. Enable the module.
2. Go to the **Manage form display** page of an entity that has a link field.
3. From the **Widget** select list, choose **Link with selection handler**.
4. Press the **Edit** (gear) button. The additional configuration appears,
   working much like Entity Reference field settings — choose the reference method
   (for example a Views‑based selection handler) and its options.
5. If the reference‑method settings do not stick, press **Update**, then open
   **Edit** again and set them a second time (a known issue, noted above).
