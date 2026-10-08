<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Parents Index — agent index

Builds an **index table storing every ancestor Term ID for each taxonomy term** (query all parents
efficiently, filter content by any ancestor — no parent-chain walking). Config at
`taxonomy_parents_index.reindex_form`; provides permissions. Version **1.0.4**. Core `^8||^9||^10||^11`.

Taxonomy/performance — derived index reflecting the hierarchy; no access role beyond permission (reindex).
