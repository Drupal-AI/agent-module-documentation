# Link title formatter — manual setup guide

**Link title formatter** (`link_title_formatter`) is a field formatter that
renders the **title** stored on a Link field as plain text, dropping the anchor
entirely. A link field holds two things — a URI and a title — and core's
formatters always render them together as a clickable link. This module gives you
just the label.

There are plenty of displays where only the label is wanted: a teaser that lists
related resources by name without inviting a click away, a card where the whole
card is already the link and a nested anchor would be invalid markup, a print or
email view mode where a link means nothing, or a search index that should hold the
label as text rather than as markup. A common pairing is with **UI Patterns**,
where a button component takes the URL and the label as two separate fields —
combine this formatter with the **Display Copy Field** module so one copy of the
field renders just the URL and the other renders just the title.

Doing this without the module means a Twig template override per view mode or a
preprocess function, both of which hide presentation logic where it is harder to
find. A formatter is the right layer — you choose it in Manage display, per view
mode, and the change is visible where a site builder expects to look. It depends
only on core **Link**.

One thing to remember: if a link field has **no title stored**, this formatter has
nothing to render — so on fields where the title is optional, decide what the
display should do for the empty case.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable, and
   select the formatter.

There is **no configuration page** for this module — it has no menu or modifiable
settings. You choose the formatter per link field on **Manage display**, described
below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage display**, where you pick the **Link Title Text** formatter
for a link field, per view mode.

## How to use it

1. Enable the module.
2. Go to the **Manage display** page for a content type (or other entity) that has
   a link field, choosing the view mode you want to affect.
3. In the **Format** column for that link field, choose **Link Title Text** and
   save.

The field now renders its stored title as plain text, with no surrounding anchor.
