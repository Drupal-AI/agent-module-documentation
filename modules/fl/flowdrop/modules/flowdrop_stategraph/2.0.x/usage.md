<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop State Graph runs workflows as a stateful graph — accumulating state through reducers, checkpointing between steps, and able to pause for a human.

---

This is the execution model that agent frameworks converge on, and it is a different shape from a queue of independent jobs. A state graph carries a single evolving state object through the graph; each node returns an update, and a **reducer** decides how that update merges into the state — append to a message list, overwrite a field, sum a counter. That is what lets a graph loop, revisit nodes and accumulate context without every node having to thread state manually.

**Checkpointing** is what makes it durable. State is persisted between steps, so a run can survive a crash, be resumed, be inspected mid-flight, or be rewound to an earlier point — which is also the mechanism that makes human-in-the-loop practical: the graph checkpoints, waits for input, and resumes from exactly where it stopped rather than restarting.

Use it where a run has memory and branching that depends on accumulated context — an agent that plans, acts, observes and re-plans; an approval process that returns to the same node with new information. Use the queue-based `flowdrop_runtime` where steps are independent and the shape is a pipeline. Both read the same workflow definitions.

---

- Run a workflow as a stateful graph.
- Accumulate state across graph nodes.
- Merge node output with a reducer.
- Append to a message history across steps.
- Checkpoint state between steps.
- Resume a run after a crash.
- Inspect state mid-run.
- Rewind a run to an earlier checkpoint.
- Pause a graph for human input.
- Resume exactly where a run stopped.
- Loop back to a node with new context.
- Build a plan-act-observe agent.
- Branch on accumulated state.
- Model an approval process that revisits steps.
- Choose between graph and queue execution.