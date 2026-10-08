# In Other Words — manual setup guide

**In Other Words** (`inotherwords`) provides field formatters that make lists read
the way a person would actually write them. Out of the box, Drupal renders a
multi‑value field as a plain, repetitive list. In Other Words can instead join the
values grammatically — with a proper "and" and, if you like, an Oxford (series)
comma — and it can condense a long sequential list into a short, natural phrase.

The two things it does are best shown by example. For **punctuating lists**, a set
of chosen flavors becomes a real sentence fragment:

> Our flavors include chocolate, vanilla, strawberry, and peppermint chocolate chip.

For **shortening sequential lists**, a run of consecutive taxonomy terms is
collapsed into a range. If an author selects *Monday, Tuesday, Wednesday, Thursday*
from the days of the week, the formatter can output:

> Monday through Thursday.

It can even mix the two — turning *Sunday, Monday, Tuesday, Wednesday, Friday* into
"Sundays, Mondays through Wednesdays, and Fridays." All of this is purely about
**display**: the stored field values are never changed, and the module has no
access‑control role. It works on text lists, entity‑reference labels (including
taxonomy terms), and — for summarizing sequences — taxonomy terms ordered by their
position in the vocabulary.

> **A note on versions.** You are reading the docs for the **3.x** line, which is
> actively maintained. The 2.x line additionally offered a Smart Date / date‑range
> feature, but that feature was experimental with a known major issue and is not
> part of 3.x. This guide covers the list‑formatting features of 3.x.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings page** for this module. Everything is configured per field
on the **Manage display** tab, where you pick one of its formatters and set its
options — described in "How to use it" below.

## Where it lives in the admin menu

In Other Words adds no Configuration page. You use it entirely through the Field UI
on **Structure → Content types → *(bundle)* → Manage display** (and equivalent
Manage display tabs on other fieldable entities).

## How to use it

1. Go to the **Manage display** tab of the entity type that has the multi‑value
   field you want to format.
2. For that field, choose one of the In Other Words formatters:
   - **In other words: List** — renders any list of values as a natural‑language
     listing ("A, B and C"), with the option to include or omit the sequential
     (Oxford) comma. Works with text lists and entity‑reference labels, including
     taxonomy terms.
   - **In other words: Sequential terms** — for taxonomy‑term fields, summarizes a
     run of consecutive terms (using their order within the vocabulary) into a
     shortened form such as "Monday through Thursday."
3. Open the formatter's settings to fine‑tune the output. For the sequential
   formatter you can configure the **text before**, **text after**, and the
   connecting word or symbol that joins a range — for example the word *to* or an
   en‑dash (`–`) — and you can use natural‑language joining so the result reads as a
   real sentence.
4. Save the display, then view a piece of content to see the list rendered as
   readable prose.
