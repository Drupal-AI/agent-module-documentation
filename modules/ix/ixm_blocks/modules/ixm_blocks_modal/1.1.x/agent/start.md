<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IXM Blocks: Modal (ixm_blocks_modal) — agent index

Nested submodule of **ixm_blocks**. Content in a dialog over the page.
Version **1.1.3**. Core `^10 || ^11`.

Right for a **detour the visitor chose** (a form they opened, a larger image, a confirmation).
Wrong for delivering something unrequested — an on-load promotional modal is among the most
disliked patterns on the web.

**Four focus behaviours decide whether it works:** focus moves in on open; cannot escape while
open; Escape closes; focus returns to the opener. Any one wrong and a keyboard or screen reader
user is **trapped**. Check the same for anything the modal contains — a form in a trapped dialog
cannot be submitted.