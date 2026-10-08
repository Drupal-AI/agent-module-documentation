# External Link a11y — manual setup guide

**External Link a11y** (`external_link_a11y`) makes external links **open in a new
tab in an accessible way**. Adding `target="_blank"` to a link is easy; doing it
*accessibly* is the part most sites skip. This module adds the accompanying cues
that "open in new window" behaviour should always carry: a visually-hidden
screen-reader hint announcing that the link opens in a new window, optional extra
CSS classes or an HTML suffix, and the appropriate `rel` handling — so following an
external link doesn't quietly disorient assistive-technology users.

It's a low-level module. It provides a **field formatter** and a **WYSIWYG/text
filter** that can automatically add the `target="_blank"` attribute to external
URLs, deciding what counts as "external" by URL pattern (or by an existing
`target="_blank"`). It can optionally add values to the link's **`rel`** attribute
(`noopener`, `noreferrer`) and, for the filter, extra CSS classes or an HTML
suffix. It depends on core **Link** and has no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no global settings form** for this module. You configure its behaviour
per field (via the formatter) and per text format (via the filter), as described in
"How to use it" below.

## Where it lives in the admin menu

External Link a11y adds no central configuration page. Its two entry points are:

- **Field formatter** — on a Link field's **Manage display**
  (**Structure → Content types → *(type)* → Manage display**).
- **Text-format filter** — on the filters list at **Configuration → Content
  authoring → Text formats and editors**
  (`/admin/config/content/formats`).

## How to use it

There are two ways to apply the accessible external-link treatment; use whichever
fits where your links come from.

**For Link fields (the formatter):**

1. Go to the relevant bundle's **Manage display**.
2. For your Link field, choose the External Link a11y formatter.
3. Configure how external links are detected and which attributes/cues are added
   (target, `rel="noopener noreferrer"`, the screen-reader "opens in new window"
   text, extra classes or suffix).

**For rich-text body content (the filter):**

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the text format used by your editors.
2. Enable the External Link a11y filter and configure its options (external-link
   detection, `target="_blank"`, and the `rel` and accessibility cues).
3. Save the format. External links in content using that format now get the
   accessible treatment automatically.

> **Tip:** when links open in a new tab, an announced "opens in a new window" cue
> helps assistive-technology users. This module adds that cue for new-tab links, and
> the `rel` values (`noopener`, `noreferrer`) are available as opt-in checkboxes on
> both the formatter and the filter.
