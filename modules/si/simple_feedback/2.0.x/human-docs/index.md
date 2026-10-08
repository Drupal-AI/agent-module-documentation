# Simple Feedback — manual setup guide

**Simple Feedback** (`simple_feedback`) adds a small block to node pages that asks
"Was this article helpful? Yes | No". A visitor clicks Yes for a +1 or No for a −1,
gets a short thank‑you message back via AJAX, and the vote is recorded. It is
deliberately tiny and plug‑and‑play — under 300 lines of code, no configuration
screens, and no dependency on a voting framework — aimed at anyone who just wants a
simple thumbs‑up/thumbs‑down signal on how useful a page is.

Under the hood, clicking a link calls an AJAX endpoint
(`/ajax/simple_feedback/{node}/{feedback}`) that stores the vote — node id, user
id, timestamp, and client IP — in a custom `simple_feedback` database table. A
second endpoint returns the current Yes/No tallies as JSON. Votes are deduplicated
per node and IP: casting the same vote again does nothing, while changing your vote
updates the existing record. Database queries are parameterized (no SQL‑injection
risk).

There is **no settings form**: you use the module by placing its block. A couple of
things are worth knowing before you rely on it. Both endpoints use the core
*Access content* permission, so **anonymous visitors can vote**, and the tally is a
soft signal rather than a rigorous metric. Treat it as a lightweight content‑quality
hint, not authoritative data.
Reporting is currently done with a simple SQL query (a Views integration is on the
roadmap); see the project's README for the query. Note also that this project is
**not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the prompt to appear
   (typically at the bottom of article content).
3. Place the **Simple Feedback** block. You can use the block's visibility settings
   to show it only on the content types where it makes sense.
4. **Save block**.

Node pages now show "Was this article helpful? Yes | No". Clicks are recorded to the
`simple_feedback` table and the visitor sees a short acknowledgement. To read the
results before the planned Views integration lands, query the table directly as
described in the module's README.
