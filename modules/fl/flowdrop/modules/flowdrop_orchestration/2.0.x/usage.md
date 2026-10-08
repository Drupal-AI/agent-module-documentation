<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Orchestration defines the plugin system and contracts that workflow execution is built on.

---

Underneath the editor and the runtime there has to be an agreement about what a node is, what an edge is, how data flows between them and what an execution engine must implement. This submodule is that agreement — the interfaces, the plugin system and the helper services that everything else in the suite codes against.

For a site builder it is invisible infrastructure. For anyone extending the suite it is the first thing to read: a custom node type, an alternative execution strategy or an integration with another automation system all implement contracts defined here.

Keeping the contracts in their own submodule rather than in the main module is what allows the parts above them — runtime, state graph, executor, connector — to be swapped or added independently. It is the reason FlowDrop can offer both a queue-based runtime and a state-graph orchestrator without either one depending on the other.

---

- Define the contracts workflow execution implements.
- Read the interfaces before writing a custom node.
- Implement an alternative execution strategy.
- Integrate another automation system.
- Share helper services across the suite.
- Keep execution engines independent of each other.
- Extend the suite without patching it.
- Understand how nodes and edges are modelled.
- Trace how data flows between nodes.
- Add a new orchestration plugin.
- Learn the suite's architecture from its contracts.
- Keep the runtime and state graph decoupled.
- Audit which orchestration plugins a site has.
- Plan an extension to the workflow system.
- Swap an execution engine without touching node code.
- Document the contracts for a team extending the suite.
