<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Blocks with Lazy Builder — agent index

Adds **lazy-builder behaviour to Views blocks** (deferred rendering — improves cacheability of the
surrounding page; a dynamic Views block doesn't bust page cache). Depends on core `views`. Version
**1.0.4**. Core `^9||^10||^11`.

Performance/rendering — block content respects the View's access; no access role.
