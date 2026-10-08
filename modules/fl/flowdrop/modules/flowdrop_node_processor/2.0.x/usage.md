<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Node Processor supplies the built-in node plugins — the ones that move data, branch on conditions, loop over collections and call AI models.

---

This is the standard library of the suite. Everything an author drags onto the canvas out of the box is implemented here: data-flow nodes that pass and reshape values, logic nodes that branch, iteration nodes that loop over a collection, and AI nodes that call a model through the AI module's abstraction.

Knowing that these live in one submodule is useful for two reasons. It is the reference implementation to read when writing a custom node — the plugin interface is easier to learn from working examples than from documentation. And it is the place to look when a node behaves unexpectedly, rather than searching the whole suite.

The AI integration is worth noting specifically: because it goes through the AI module's provider abstraction, a workflow written against one model runs against another by changing configuration, and the credential stays in the provider rather than in the workflow definition.

---

- Pass and reshape data between nodes.
- Branch a workflow on a condition.
- Loop over a collection of items.
- Call an AI model from a workflow.
- Transform a value between steps.
- Filter items in a workflow.
- Combine outputs from several nodes.
- Read a reference implementation for a custom node.
- Debug unexpected node behaviour.
- Swap AI models without editing workflows.
- Keep AI credentials out of workflow definitions.
- Build a data pipeline visually.
- Aggregate results from an iteration.
- Short-circuit a workflow on a condition.
- Learn the node plugin interface from examples.