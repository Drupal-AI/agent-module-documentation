<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Node Processor (flowdrop_node_processor) — agent index

Submodule of **flowdrop**. The **built-in node plugins**: data flow, logic, iteration, AI
integration. Version **2.0.0**. Core `^11.3`.

The suite's standard library — everything on the canvas out of the box. Two reasons to point
people here: it is the **reference implementation** for writing a custom node (easier than the
docs), and it is where to look when a node misbehaves.

AI nodes go through the **AI module's provider abstraction**, so a workflow written against one
model runs against another by configuration, and the credential stays in the provider rather than
in the workflow definition.