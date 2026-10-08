<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edit Content Type Tab — agent index

Adds a **tab to change the content type (bundle) of the current node** (convert a node between types in
place). Version **2.0.x** (dev). Core `^9||^10||^11`.

**CAUTION — powerful/destructive:** changing a node's content type can **drop/remap fields (data loss)** and
isn't routine editorial. **Restrict to trusted administrators** (gate the route tightly), test first, back up
before bulk conversions. No dedicated access role — relies on route access.
