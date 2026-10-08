<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Node Type is the entity that defines which node plugins are available in the editor and how each is configured.

---

A visual workflow editor needs a vocabulary: the set of blocks an author can drag onto the canvas. This submodule holds that vocabulary as entities, one per node type, each bound to a node plugin and carrying its configuration.

Making node types entities rather than pure plugin definitions is a deliberate choice with a practical payoff. A site can add, configure and restrict node types without writing code — expose an HTTP node but not a raw PHP one, preconfigure an AI node with the model and system prompt a team should use, hide node types that are not relevant to a project. The palette becomes a curated set rather than everything the code offers.

It pairs with `flowdrop_node_category`, which groups node types into sections of the palette, and `flowdrop_node_processor`, which supplies the built-in plugins these entities point at.

---

- Define which node types the editor offers.
- Configure a node type's defaults.
- Preconfigure an AI node with a model.
- Hide node types irrelevant to a project.
- Restrict authors to approved node types.
- Add a node type without writing code.
- Bind a node type to a plugin.
- Group node types into palette sections.
- Curate the editor palette for a team.
- Standardise node configuration across workflows.
- Document what each node type does.
- Audit which node types a site exposes.
- Roll out a new node type to authors.
- Retire a node type safely.
- Review node types during a security audit.