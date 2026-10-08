<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Pipeline (flowdrop_pipeline) — agent index

Submodule of **flowdrop**. Entity for **one complete workflow run** — overall state, grouping its
`flowdrop_job` records. Version **2.0.0**. Core `^11.3`.

The run-level record. Without it, operational questions ("how many in flight?", "which are
stuck?", "did the run that trigger fired actually finish?") require reconstructing a run from
scattered job records.

Also where retry and cancellation live: cancelling *a workflow* means cancelling a **run**, not a
definition — and a run is a pipeline.