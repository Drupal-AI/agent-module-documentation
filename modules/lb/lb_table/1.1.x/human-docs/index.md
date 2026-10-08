# Y Layout Builder — Table — manual setup guide

**Y Layout Builder — Table** (`lb_table`) provides a responsive **table block
type** for YMCA Layout Builder pages. It is part of the YMCA Website Services
family of Layout Builder components (the `y_lb` package), and it is how a location
publishes a schedule, a price list, or a comparison as structured tabular data
rather than pasted markup.

Modelling a table as a block type is what keeps it usable over time. A table an
editor maintains in a WYSIWYG drifts — it loses its header row and becomes
unreadable on a phone — whereas a block type enforces the structure. Two things
decide whether a table works, and both can be handled once here rather than page
by page: **real header cells with the right scope**, so a screen reader announces
context instead of a stream of values; and a **deliberate responsive strategy**,
since horizontal scrolling preserves comparisons while stacking rows destroys
them. The module also depends on **Data Layer** (`datalayer`), which suggests
table interactions are reported to analytics — a data-collection decision as much
as a measurement one.

This module is designed to be used **with the YMCA's Website Services
distribution**. Its hard dependency on **Y Layout Builder (`y_lb`)** means it is
not a standalone install — see [Installation](installation/index.md) for the
important note about where `y_lb` actually comes from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer/Drush
   commands, and the `y_lb` dependency caveat.

This module has **no configuration page** of its own. You place and edit the
table block from within the Layout Builder interface, described below.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). Everything happens in
**Layout Builder**: edit a page's layout, add the Table block, and enter the
table's rows and columns. For general Layout Builder mechanics, see Drupal core's
Layout Builder.

## How to use it

1. Enable the module (and the rest of the YMCA Website Services / `y_lb` stack it
   belongs to).
2. Edit a page's **Layout** (Layout Builder) and **add** the Table block to a
   section.
3. Enter the table data. Give it real header cells so it stays accessible, and
   decide up front how it should behave on small screens.
4. Save the layout.
