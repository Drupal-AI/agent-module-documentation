<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop State Graph (flowdrop_stategraph) — agent index

Submodule of **flowdrop**. **Stateful graph orchestrator**: reducers, checkpointing,
human-in-the-loop. Version **2.0.0**. Core `^11.3`.

Different execution model from `flowdrop_runtime`'s queue of independent jobs. A single evolving
state object passes through the graph; each node returns an update and a **reducer** merges it
(append to a list, overwrite, sum). That is what lets a graph loop, revisit nodes and accumulate
context.

**Checkpointing** makes it durable — survive a crash, resume, inspect mid-flight, rewind. It is
also the mechanism behind human-in-the-loop: checkpoint, wait, resume exactly where it stopped.

Choose it for runs with memory and context-dependent branching (plan-act-observe agents, approval
loops). Choose `flowdrop_runtime` for independent pipeline steps. Both read the same definitions.