<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Job is the entity recording one node's execution — its status, what went in and what came out.

---

When a workflow run misbehaves, the question is always which node and with what data. A job entity answers it: one record per node execution, carrying the status, the input it received and the output it produced.

That makes runs inspectable after the fact rather than only while they are happening. An AI node that returned something unexpected, an HTTP node that got a 500, a transform that silently produced an empty array — each is a job record you can open, with the actual values rather than a log line about them.

It is also what makes retry meaningful. Knowing the exact input a failed node received is what lets it be re-run without re-running everything before it.

Jobs are grouped by `flowdrop_pipeline`, which represents the run as a whole; the runtime creates both.

---

- Record a single node's execution.
- See what input a node received.
- See what a node produced.
- Find which node in a run failed.
- Inspect an AI node's actual response.
- Debug a transform that produced nothing.
- Retry a failed node with its original input.
- Audit what a workflow did with data.
- Group jobs by their pipeline run.
- Track execution status per node.
- Measure how long a node took.
- Compare inputs across runs.
- Investigate an unexpected workflow outcome.
- Report on node failure rates.
- Keep an execution trail for compliance.