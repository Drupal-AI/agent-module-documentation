# Poll — manual setup guide

**Poll** (`poll`) lets your site ask visitors a multiple‑choice question and
tally their votes. Each poll is a small piece of content: a question plus a set
of answer choices. When a poll is shown, visitors who are allowed to vote see
radio buttons for the choices; after they vote (or if you let them peek early)
they see the running results as a bar chart.

This is the same Poll module that used to ship inside Drupal core. It now lives
as a contributed project. Under the hood it defines two content types — the
**poll** (the question and its settings) and the **poll choice** (one answer
option) — while the individual **votes** are stored in their own database table
rather than as content, so a busy poll doesn't clutter your content lists.

Each poll carries its own rules: whether it's open or closed, whether it
auto‑closes after a set duration, whether anonymous visitors may vote (and if so
whether they're limited by IP address, by browser session, or not at all),
whether people can cancel and recast their vote, and whether results are visible
before voting. The module also ships a **"Most recent poll"** block so the newest
open poll can appear in any theme region, plus a set of granular permissions that
let you decide exactly who can create, edit, view, and vote on polls.

> **Note on stability:** the documented release, **2.0.0‑alpha5**, is an *alpha*
> (pre‑stable). Its behaviour and data structures may still change before a
> stable release, so test carefully before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the optional `poll_devel` submodule.
2. [Configuration](configuration/index.md) — creating and running polls: the
   per‑poll settings, the permissions, and the "Most recent poll" block.

## Where it lives in the admin menu

- **Polls overview:** **Content → Polls** (`/admin/content/poll`) lists every
  poll for moderators.
- **Add a poll:** `/poll/add`.
- **View a poll:** `/poll/{id}` — this is where visitors vote.
- **Settings:** **Configuration → Content authoring → Poll**
  (`/admin/config/content/poll`) exists but is currently an empty stub — Poll has
  no global settings. Everything is configured per poll.

## How to use it

1. Enable the module and grant the relevant [permissions](configuration/index.md).
2. Go to `/poll/add`, type your question, add your answer choices, and set the
   poll's rules (duration, anonymous voting, and so on).
3. Save. Visitors can now vote at the poll's page, and you can place the "Most
   recent poll" block in a sidebar to surface it automatically.
