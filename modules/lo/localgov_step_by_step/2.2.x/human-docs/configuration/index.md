# Configuration

LocalGov Step by step has no settings form — you "configure" it by building
journeys out of the content types it provides and placing its block. This page
walks through that.

## Build a journey

A journey is one **overview** page plus a series of **step pages**:

1. **Create the overview.** Go to *Content → Add content → **Step by step
   overview***. This is the journey's entry page — give it a title (for example
   "Report a pothole") and save it.
2. **Add step pages.** Create *Step by step page* nodes, one per step. On each step
   page, set its **parent** (the `localgov_step_parent` field) to the overview you
   just created.
3. **Let the list build itself.** When you save a step page, the module checks
   whether its overview already references it and, if not, appends it to the
   overview's ordered list and saves the overview. You do not have to maintain the
   list by hand.
4. **Reorder the steps** on the overview node's ordered list of step pages whenever
   you need a different sequence.

Each step gets its own URL (via the Path module), so steps can be linked to
directly, and the shipped `localgov_step_by_step_navigation` view renders the steps
as a numbered journey.

## A note on the one-way sync

The automatic append is **one-way**: saving a step page updates its overview, but
there is no reverse pass. If you clear a step page's parent, it is **not**
automatically removed from the old overview's list — tidy that up by editing the
overview. The sync is also wrapped in error handling: if it fails, the failure is
logged to the `localgov-step-by-step` log channel and your page save still
succeeds, so an editor is never blocked by a sync problem.

## Place the "part of" block

The **Step part of** block shows the containing journey and the visitor's current
position, and is meant to appear on every step page:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the *Step part of* block in a suitable region of your theme.
3. Save the block layout.

The same block is reused across all steps of every journey.

## Share a draft with Preview Link

Because the module depends on **Preview Link**, you can share an unpublished journey
with a reviewer before it goes live. A preview link created on an overview covers
its steps too (via the module's Preview Link autopopulate integration), so a
reviewer can walk the whole journey from a single link.

## Scheduled publishing

If **Scheduled Transitions** is installed, journeys and steps can be set to publish
and unpublish automatically at chosen times — the module grants the matching
scheduled-transition permissions for both content types when that module is present.
