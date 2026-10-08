<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Orchestration (flowdrop_orchestration) — agent index

Submodule of **flowdrop**. The **plugin system, contracts and helper services** underneath workflow
execution. Version **2.0.0**. Core `^11.3`.

Invisible to site builders; **the first thing to read when extending the suite** — custom node
types, alternative execution strategies and integrations with other automation systems all
implement contracts defined here.

Keeping contracts in their own submodule is why FlowDrop can offer both a queue-based runtime
(`flowdrop_runtime`) and a state-graph orchestrator (`flowdrop_stategraph`) without either
depending on the other.