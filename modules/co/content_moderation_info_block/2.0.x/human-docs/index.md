# Content Moderation Info Block — manual setup guide

**Content Moderation Info Block** (`content_moderation_info_block`) provides a block
that shows content-moderation information about the entity currently being viewed —
and, optionally, lets an editor change the moderation state right there, outside the
entity's edit form. It offers the kind of at-a-glance moderation panel that
Workbench Moderation gave Drupal 7 sites.

Placed on a page, the block can display: the entity's **changed date**, its
**author**, whether you're looking at the **latest revision** (Yes/No), the
**current moderation state**, and a small **form to change the moderation state**
(complete with a revision log message field). Each of these is a checkbox on the
block's own configuration, so you show only the pieces you want.

The block is derived per moderated entity type and reads the entity from its block
context; each piece of information is a checkbox you turn on or off. When the
state-change form is enabled for a moderated entity, the moderation options it offers
are the transitions core Content Moderation permits for the current user. Which
viewers see the block at all is controlled by the block's standard visibility
settings, so place it in a region and with visibility conditions appropriate for your
editors. Its only dependency is core **Content Moderation**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no global settings form**. You set the block up where it's placed, using
the standard block configuration described below.

## How to use it

1. Enable the module.
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Place block** in the region where you want the moderation info to appear,
   and choose the **Content Moderation Info** block.
4. In the block's configuration, tick the pieces of information you want to show —
   changed date, author, latest-revision indicator, current state, and/or the
   state-change form — and set the usual block visibility conditions.
5. Save the block.

Now, when a viewer looks at a moderated entity where the block is placed, the block
displays that entity's moderation details and (if enabled) offers a state-change form
whose options are the transitions core Content Moderation allows that user, without
opening the edit form.
