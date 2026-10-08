<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Workflow Executor (flowdrop_workflow_executor) — agent index

Submodule of **flowdrop**. Run a workflow **from inside another**, synchronously or
asynchronously. Version **2.0.0**. Core `^11.3`.

Composition is what stops a workflow library becoming near-duplicate giants — shared parts become
one workflow used by many, so a bug is fixed once.

**Sync vs async is the design decision.** Sync = caller waits and uses the result (the child
computes something the parent needs). Async = fire and forget for side effects (notifications,
logging, syncing) — no latency added, and the parent's success is not coupled to the child's.

**Two cautions:** sync nesting composes latency (parent + child + model call); and recursion is
possible through a chain, so a depth guard is needed.