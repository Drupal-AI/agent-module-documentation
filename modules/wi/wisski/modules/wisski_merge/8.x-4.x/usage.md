<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Merge combines multiple instances or records into a single one, as part of the APUS processing family.

---

A second merge implementation, this one nested under `wisski_apus` — WissKI's content and annotation processing base. Where `wisski_data_merge` is the general data-cleaning merge, this sits in the processing pipeline, which suggests it is intended for merges that happen as part of an automated flow rather than as an editorial action.

That distinction matters when planning. A merge performed by a person reviewing candidates carries their judgement; a merge performed by a pipeline carries whatever rule the pipeline encodes, and a rule that is slightly wrong applied across a whole import is a large problem discovered late.

**If a project runs automated merging, the questions to settle are what the rule is, what it does with ambiguous cases, and whether the result is reviewable before it is committed.** "Merge anything with the same normalised label" is a defensible rule for a controlled import and a destructive one for free-text catalogue data.

Establish which merge implementation a project actually uses — two are available and they belong to different workflows.

---

- Merge instances in a processing pipeline.
- Consolidate records during an import.
- Apply an automated merge rule.
- Decide how ambiguous cases are handled.
- Review pipeline merges before committing.
- Distinguish editorial from automated merging.
- Establish which merge module a project uses.
- Plan a merge rule for a controlled import.
- Avoid automated merging of free-text data.
- Audit merges performed by a pipeline.
- Combine with duplicate detection.
- Roll back an incorrect automated merge.
- Test a merge rule on a sample.
- Document the merge rule for a project.
- Compare with the editorial merge module.
- Document the rule for reviewers.
