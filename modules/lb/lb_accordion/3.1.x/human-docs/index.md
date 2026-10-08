# Y Layout Builder - Accordion Block — manual setup guide

**Y Layout Builder - Accordion Block** (`lb_accordion`) provides a collapsible‑panel
**block type** for pages built with the YMCA's Y Layout Builder package. Each block
holds an ordered list of expandable title/body items (`accordion_item` sub‑blocks),
using the [Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder)‑based
component system from the YMCA Website Services distribution.

An accordion is the right pattern when a page has many self‑contained items — the
questions everyone asks about membership options, opening arrangements, or programme
details — where each answer stands on its own and showing all of them at once would
bury the page. It suits **independent items** well and suits **narrative prose
badly**, because collapsing a continuous argument hides the thread a reader is
following. It is also worth deciding whether the first panel starts open: everything
closed is tidy but hides content from people who are scanning (and from search
snippets), while opening the first panel signals the pattern at little cost. The block
template opens the first item by default.

If the accordion holds question/answer pairs, the **"Is FAQ?"** checkbox emits a
`FAQPage` structured‑data (JSON‑LD) block into the page head so search engines can
recognise it. Google's guidance is to add only **one** FAQ accordion per page; if more
than one is flagged, only the first is output.

If you build one of these accordions, the accessibility requirements are specific
and are the part most often missed. Each header must be a real **button** (not a
styled `div`), carrying `aria-expanded` that reflects the panel's state and
`aria-controls` pointing at its panel, and the panel must be reachable by keyboard.
A click‑only accordion is content a keyboard user cannot open at all — verify these
against what the block actually renders.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install it as part of the YMCA Website
   Services distribution (please read the important dependency note there first).

There is **no settings form** for this module. It is a block type you place and fill
in through Layout Builder.

## Where it lives in the admin menu

This module is meant to be used **within the YMCA's Website Services distribution**,
not as a standalone module on an arbitrary site. Once the distribution is in place,
you add and edit accordion blocks through the Y Layout Builder page‑building
interface. See [Installation](installation/index.md) for the important note about
its `y_lb` dependency before attempting to add it to a project.
