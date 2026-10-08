<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Edit Action — agent index

A **bulk action to edit multiple nodes at once**. Depends on core `node`. Version **1.1.1**. Core `^9.4||^10||^11`.

Content-editing — **access-correct**: checks `$node->access('update')` per node before editing (doesn't bypass
entity access). No access role of its own.
