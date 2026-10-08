<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Scheduler adds an "Expiry" visibility condition to every block. Set a Publish Date and/or an Expiry Date on a block in the block layout UI and the block is shown only inside that window — no cron, no separate settings page.

---

Block Scheduler is a small module that registers a single core `Condition` plugin (`expiry`) so it appears in the "Visibility" section of every block's configuration form (both classic block layout and Layout Builder block configuration). The condition adds two `datetime` fields — **Publish Date** (`start`) and **Expiry Date** (`end`) — stored as Unix timestamps in the block's visibility configuration. A block is visible only when the current time is at or after the start and at or before the end; either field may be left blank for an open-ended window, and leaving both blank is a no-op (the block always shows).

Enforcement is real-time and happens two ways: the `expiry` condition's `evaluate()` participates in normal block visibility evaluation, and `hook_block_access()` independently forbids the "view" operation on any block whose stored `expiry` config falls outside the window. The condition also implements `getCacheMaxAge()`, returning the number of seconds until the next boundary (start or end) so cached pages naturally expire when a block is due to appear or disappear. There is no cron job, no admin settings page, no permissions, and no config schema shipped by the module; all state lives in the host block's own visibility configuration. Optional integration: if the contrib `markdown` module is present, the module's help page renders `README.md` through it.

---

- Show a promotional banner block only during a sale (set both Publish Date and Expiry Date).
- Publish a block automatically at a future date/time without editing it again (set Publish Date only).
- Auto-hide a block after a deadline, such as an event registration link (set Expiry Date only).
- Schedule a holiday/seasonal block to appear and disappear on fixed dates.
- Roll out a site-wide announcement block at launch time and retire it later.
- Time-box a maintenance notice block to a planned window.
- Display a "new feature" callout block for the first week after a release.
- Hide a countdown or "offer ends soon" block once the offer expires.
- Rotate homepage hero blocks by giving each a non-overlapping schedule window.
- Show a conference/webinar signup block only in the lead-up to the event.
- Retire an outdated sidebar block on a set date while leaving it configured.
- Schedule a legal/compliance notice block to go live on a regulation's effective date.
- Time-limit a donation or fundraising drive block.
- Coordinate a coming-soon teaser block to flip to a live block at go-time (two blocks, complementary windows).
- Automatically unpublish a job-posting block after the application deadline.
- Schedule store hours / seasonal notice blocks without manual toggling.
- Show a flash-sale block for a precise start-to-end interval.
- Keep an editorially-configured block staged and hidden until its embargo lifts (Publish Date).
- Ensure caches invalidate exactly when a scheduled block should change, via the condition's cache max-age.
- Apply scheduling to any block type — content blocks, views blocks, system blocks — since it is a generic visibility condition.
