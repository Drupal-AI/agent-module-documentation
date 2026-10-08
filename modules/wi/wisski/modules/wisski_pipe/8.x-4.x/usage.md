<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Pipe composes processors into pipelines that analyse, transform and enhance data.

---

Data work in a research collection is rarely one operation. A typical enhancement is: take the description, find entity mentions, reconcile them against an authority, attach the identifiers, record the provenance. Each step is a processor; the value is in composing them.

This submodule provides that composition — pipes of processors, each consuming the previous one's output.

The architectural benefit is testability. A pipeline built from named steps can be run partially, inspected between stages and changed one step at a time, which matters because data enhancement is always iterative: the first run reveals what the data is actually like, and the mapping changes accordingly.

**Ships under the project's `legacy/` directory.** Its sibling `wisski_apus` is the newer processing base, and `flowdrop` in this same wave shows what a modern take on the pattern looks like. For a current project, establish what the recommended path is rather than starting here — but the composable-processor model is sound and worth recognising wherever it appears.

---

- Compose processors into a pipeline.
- Enhance data in stages.
- Reconcile entities as a pipeline step.
- Attach identifiers automatically.
- Record provenance for enhancements.
- Run a pipeline partially.
- Inspect data between stages.
- Change one processor without rebuilding.
- Iterate an enhancement workflow.
- Check its legacy directory status.
- Compare with the APUS processing base.
- Find the current recommended path.
- Test a pipeline on a sample.
- Audit what a pipeline changed.
- Plan a data enhancement project.
