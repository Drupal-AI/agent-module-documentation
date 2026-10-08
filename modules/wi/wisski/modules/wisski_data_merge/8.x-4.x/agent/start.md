<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Data Merge (wisski_data_merge) — agent index

Submodule of **wisski**. **Merges** duplicate records. Version **8.x-4.3**. Core `>=10.4 <12`.
Resolution half of `wisski_duplicate`'s detection.

**Reference redirection is what makes semantic merging harder than relational.** A record is
referenced by triples, possibly across adapters and possibly by other institutions if identifiers
were published. A merge that consolidates but leaves references pointing at a non-resolving URI has
traded one problem for a worse one.

**Insist on two things before merging at scale:** back up the triple store (a merge is not
straightforwardly reversible), and decide what happens to the absorbed URI — deleted, or retained
as a redirecting alias. If those identifiers were ever published, deletion breaks other people's
links.