# Reviewer Notes — manual setup guide

**Reviewer Notes** (`reviewer_notes`) adds a lightweight overlay that lets editors
and stakeholders leave **in-context notes anywhere on a page** during content
review. Instead of collecting feedback in a spreadsheet or a separate document,
reviewers annotate the page itself — pinning a note to a specific element or leaving
a page-level "quick note" — tag it, track whether it is Open or Resolved, and
discuss it through per-note comments and an activity log.

There are two kinds of note: an **Annotated element** note anchors to a specific
HTML element (a heading, an image, a call to action), and a **Quick note** applies
to the page as a whole. Notes carry tags so large review sets can be filtered
(clicking a tag adds it to the filter, using OR logic), and each note moves between
**Open** and **Resolved** with the UI updating live. A "Go to" action scrolls back
to the anchored element. Every POST endpoint is CSRF-protected.

Beyond the overlay, the module includes a **site-wide admin report** where you can
browse notes across the site (filtered by path or tags) and export them to CSV —
handy for launch checklists, sign-off history, QA, accessibility reviews, and
migration validation. **URL rules** (which support wildcards) control where the
overlay appears, and the module works with both URL aliases and system paths.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The setup that matters is choosing where the overlay appears and who can use it,
described in "How to use it" below.

## How to use it

1. After enabling the module, review the **permissions** it adds at **People →
   Permissions** (`/admin/people/permissions`) and grant them to the roles that
   should be able to see the overlay and add or manage notes.
2. Set up **URL rules** to control which pages show the review overlay (the rules
   support wildcards, and match both aliases and system paths). Limit it to the
   pages under review so the overlay does not appear site-wide unless you want it
   to.
3. Reviewers then open a page covered by a rule, add **Annotated element** or
   **Quick note** notes, tag them, and move each between Open and Resolved as work
   progresses, using comments and the activity log to collaborate.
4. To see everything in one place, open the **admin report** to browse notes across
   the site, filter by path or tags, and export to CSV.
