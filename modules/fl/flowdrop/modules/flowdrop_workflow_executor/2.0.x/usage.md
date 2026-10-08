<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Workflow Executor lets one workflow call another, either waiting for the result or firing it off asynchronously.

---

Composition is what stops a workflow library becoming a set of near-duplicate giants. Once a workflow can call another, the shared parts — enrich a record, notify a channel, run a content check — become one workflow used by many rather than the same twelve nodes copied into each. Fixing a bug then means fixing it once.

The synchronous/asynchronous choice is the design decision this submodule surfaces. **Synchronous** means the caller waits and can use the result, which is what you want when the sub-workflow computes something the rest of the parent needs. **Asynchronous** means fire and forget, which is what you want for side effects — notifications, logging, syncing — where making the parent wait adds latency for no benefit and couples the parent's success to the child's.

Two things to keep in mind. Synchronous nesting composes latency: a parent waiting on a child waiting on a model call is as slow as the sum. And recursion is possible — a workflow that reaches itself, directly or through a chain, needs a depth guard.

---

- Call one workflow from another.
- Reuse a common sub-workflow.
- Avoid duplicating node sequences.
- Fix shared logic in one place.
- Wait for a sub-workflow's result.
- Fire a side-effect workflow asynchronously.
- Keep notifications off the critical path.
- Compose a large process from smaller workflows.
- Build a library of reusable workflows.
- Pass data into a sub-workflow.
- Return a result to the calling workflow.
- Decouple a parent's success from a child's.
- Watch latency in synchronous nesting.
- Guard against recursive workflow calls.
- Refactor a large workflow into parts.