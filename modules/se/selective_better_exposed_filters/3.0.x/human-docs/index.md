# Selective Better Exposed Filters — manual setup guide

**Selective Better Exposed Filters** (`selective_better_exposed_filters`) adds a
**"Show only used items"** option to Better Exposed Filters (BEF). With it, an
exposed Views filter lists only the reference or taxonomy values that actually
appear in the current result set, instead of every possible option — turning a long
"dead choice" dropdown into a clean, facet-like filter.

Better Exposed Filters renders Views exposed filters as select lists, checkboxes,
radios, or links, but by default those widgets show *all* configured options,
including terms or referenced entities that no content matches. This module
enhances BEF's widgets so each gains extra checkboxes in the Views UI: **Show only
used items**, **Filter items based on the already-filtered result set**, **Hide
filter if no options**, and **Show option items count**. When enabled, it quietly
re-runs the view's query to find which option values are present and prunes the
exposed element accordingly — optionally showing a per-option result count, or
hiding the filter entirely when nothing is left.

It works with core field-based reference filters — taxonomy term, entity
reference, bundle, list/options fields, VERF, and Search API options — but
deliberately not with the "Has taxonomy term" depth filter. There is no settings
page and no permissions: everything is configured per filter, inside the view's
exposed-form settings. It is a lightweight, BEF-native alternative to the Views
Selective Filters module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Better Exposed Filters.

## Where it lives in the admin menu

There is no central settings page. The options appear in the **Views** UI at
**Structure → Views** (`/admin/structure/views`) whenever you configure an exposed
filter that uses a Better Exposed Filters widget.

## How to use it

1. Make sure your view already uses Better Exposed Filters for the exposed filter
   you want to trim (BEF is a required dependency).
2. Edit the view and open the exposed filter's settings, then the **Better Exposed
   Filters** configuration for that filter.
3. Tick **Show only used items** to limit the widget to values that appear in the
   results. Optionally also enable:
   - **Filter items based on the already-filtered result set** — so one exposed
     filter narrows the options of another (cascading filters).
   - **Show option items count** — display, next to each option, how many results
     it will return.
   - **Hide filter if no options** — hide the exposed filter entirely when it would
     have no usable choices.
4. Save the view. The exposed filter now shows only the options that lead
   somewhere.
