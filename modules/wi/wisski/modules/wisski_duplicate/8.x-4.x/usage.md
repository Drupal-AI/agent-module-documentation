<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Duplicate finds records that appear to describe the same thing.

---

Duplicates are inevitable in a research database. Data arrives from several sources, cataloguers work in parallel, an authority reference is missed, and the same person or object ends up recorded twice with slightly different spellings. Left alone, duplicates fragment the data: a query for everything by one artist returns half of it, and every count is wrong.

This submodule is the detection half. It finds candidates; `wisski_data_merge` and `wisski_merge` are what resolve them.

Detection is deliberately separated from merging for good reason. **A merge is destructive and, in a research context, an editorial judgement rather than a mechanical one.** Two records that look identical may be two genuinely different objects with the same description, and merging them destroys a distinction someone made on purpose. The right workflow is: detect automatically, review by a person who knows the material, merge deliberately.

Run detection regularly rather than once. Duplicates accumulate continuously, and a database cleaned at the end of a project is a database that was wrong throughout it.

---

- Find records describing the same thing.
- Detect duplicate person records.
- Find objects recorded twice.
- Improve data quality in a collection.
- Correct fragmented query results.
- Fix inaccurate record counts.
- Review duplicate candidates before merging.
- Separate detection from merging.
- Run duplicate detection regularly.
- Catch duplicates from parallel cataloguing.
- Detect duplicates after a data import.
- Preserve genuine distinctions between similar records.
- Report duplicate rates over time.
- Plan a data cleaning workflow.
- Audit a collection before publication.
