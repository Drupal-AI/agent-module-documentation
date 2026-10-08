<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Runtime (flowdrop_runtime) — agent index

Submodule of **flowdrop**. Execution engine — **queue-based processing** plus real-time execution
monitoring. Version **2.0.0**. Core `^11.3`.

Why queue-based: workflow steps are slow, transiently failing and longer-lived than a web request.
Inline execution produces timeouts and half-finished work.

Creates and advances `flowdrop_pipeline` (whole-run state) and `flowdrop_job` (single node
execution) records. The monitoring half matters as much as execution — a visual editor makes
workflows easy to build wrong, and watching a run step through is the difference between debugging
and guessing.