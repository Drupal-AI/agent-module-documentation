<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Rabbit Hole — agent index

Search API **processor preventing indexing of Rabbit Hole-hidden content** (entities set to be hidden via
access-denied/not-found Rabbit Hole plugins stay out of the index). Depends on `rabbit_hole`, `search_api`.
Version **1.0.1**. Core `^10||^11||^12`.

Security-adjacent/consistency control — keeps hidden content out of search results (aligns the index with
Rabbit Hole's hiding). Configure the processor on the index.
