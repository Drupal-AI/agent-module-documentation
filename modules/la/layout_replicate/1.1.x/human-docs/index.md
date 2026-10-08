# Layout Replicate — manual setup guide

**Layout Replicate** (`layout_replicate`) copies
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder)
layouts — a whole layout, a single section, or a single block — from one node to
another, or between the language translations of the same node. Instead of
rebuilding a complex layout by hand on every node or every translation, you
replicate it in seconds from a single form.

The most common use is translation. A translator opening a fresh language version
of a layout‑built page normally starts from an empty canvas; Layout Replicate lets
them start from a mirror of the source layout instead, including deeply nested
inline blocks. It handles the cloning correctly: **inline blocks are deep‑cloned**
into fully independent copies, so editing one does not affect the other, while
**reusable blocks keep their shared reference** (the correct Drupal behavior), and
block order within each section is preserved.

Every clone operation is written to an activity log at
`/admin/reports/layout-replicate`, recording the source and target node, the
languages involved, and a timestamp. There is also a PHP API for developers who
need to trigger cloning programmatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Layout Builder, Node, and Block content.

There is **no settings form** for this module. It works through a **Clone Layout**
tab on Layout Builder‑enabled nodes and the activity report, both described below.

## Where it lives in the admin menu

Once enabled, a **Clone Layout** tab appears on every Layout Builder‑enabled node
for users with the **Administer nodes** permission. The activity log lives under
**Reports → Layout Replicate** (`/admin/reports/layout-replicate`).

## How to use it

1. Make sure **Layout Builder is enabled** on the content type, with per‑node
   overrides allowed. For cross‑language cloning, the core **Language** and
   **Content translation** modules must also be enabled.
2. Open a Layout Builder‑enabled node and click the **Clone Layout** tab.
3. Choose **what to clone**:
   - **Entire layout** — replaces all sections and blocks on the target with a copy
     of the source layout.
   - **A section** — appends one section (and all its blocks) to the end of the
     target layout.
   - **A block** — appends one block, inside a new section, to the end of the
     target layout.
4. Select the **source language**, optionally pick a **destination node**, choose
   the **target language**, and submit.
5. After a successful clone you are taken straight to the Layout Builder editor on
   the target node, where you can review and adjust the copied layout.
