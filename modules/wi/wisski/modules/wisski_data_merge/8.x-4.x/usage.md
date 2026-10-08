<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Data Merge consolidates records identified as duplicates into one.

---

The resolution half of duplicate handling. Where `wisski_duplicate` finds candidates, this performs the merge — combining the records' statements and redirecting references so nothing that pointed at the absorbed record is left dangling.

That reference redirection is the part that makes merging in a semantic database harder than in a relational one. A WissKI record is referenced by triples, potentially across adapters and potentially by other institutions if identifiers have been published. A merge that consolidates the record but leaves references pointing at a URI that no longer resolves has traded one data quality problem for a worse one.

**Two things to insist on before merging at scale.** Take a backup of the triple store, because a merge is not straightforwardly reversible. And confirm what happens to the absorbed record's URI — whether it is deleted, or retained as an alias that redirects. If those identifiers have ever been published, deletion breaks other people's links, and retaining an alias is the difference between consolidating data and breaking the web.

---

- Merge two records describing one thing.
- Combine statements from duplicate records.
- Redirect references to a merged record.
- Avoid dangling references after a merge.
- Back up the store before merging.
- Decide the fate of an absorbed record's URI.
- Retain an alias for a published identifier.
- Avoid breaking external links.
- Consolidate after a data import.
- Resolve duplicates found by detection.
- Merge person records with variant spellings.
- Plan a large-scale merge carefully.
- Review a merge before committing it.
- Audit merges performed on a collection.
- Understand why semantic merging is harder.
