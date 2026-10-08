<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Pipeline is the entity representing one complete workflow run, holding its overall state and grouping the jobs that make it up.

---

A workflow run is more than the sum of its node executions: it has a start, an end, an overall status, and a shared context that flows between steps. The pipeline entity is that run — the thing an operator points at when they say "this one failed" — with the individual `flowdrop_job` records hanging off it.

The grouping is what makes operational questions answerable. How many runs are in flight? Which runs are stuck? Did the run triggered by that node save actually complete? Without a run-level record those questions require reconstructing a run from scattered job records.

It also gives retry and cancellation somewhere to live: cancelling "a workflow" means cancelling a run, not a definition, and a run is a pipeline.

---

- Track a complete workflow run.
- Group a run's node executions.
- See a run's overall status.
- Find runs that are stuck.
- Count runs in flight.
- Cancel a running workflow.
- Retry a failed run.
- Correlate a trigger with its run.
- Report on run success rates.
- Measure end-to-end run duration.
- Inspect a run's shared context.
- Distinguish a run from a definition.
- Audit workflow activity over time.
- List recent runs for an operator.
- Investigate a run that never finished.