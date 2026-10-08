<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Job (flowdrop_job) — agent index

Submodule of **flowdrop**. Entity for **one node execution** — status, input, output.
Version **2.0.0**. Core `^11.3`.

Answers the only two questions that matter when a run misbehaves: **which node**, and **with what
data**. Holds the actual values, not a log line about them — which is also what makes retry
meaningful (re-run a failed node with its original input, without re-running what preceded it).

Grouped by `flowdrop_pipeline`; both created by `flowdrop_runtime`.