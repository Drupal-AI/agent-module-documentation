<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Node Category groups node types into logical sections of the editor palette.

---

With twenty-five or more node types available, a flat palette is unusable — an author looking for the HTTP node scrolls past AI nodes, logic nodes and iteration nodes to find it. Categories give the palette structure: AI, data, logic, integration, whatever grouping suits the site.

It is a small submodule with a disproportionate effect on whether the editor is pleasant to use, which is the whole argument for a visual workflow tool in the first place. A category entity is configuration, so the grouping can be adjusted per site and travels with the rest of the configuration.

Categories describe presentation, not capability — restricting what an author may use is `flowdrop_node_type`'s job, not this one. Hiding a node behind an obscure category is not a control.

---

- Group node types into palette sections.
- Make a large node palette navigable.
- Put AI nodes in their own section.
- Separate integration nodes from logic nodes.
- Order palette sections sensibly.
- Adjust grouping per site.
- Export palette grouping with configuration.
- Introduce a new category for custom nodes.
- Improve authoring experience in the editor.
- Reduce time spent hunting for a node.
- Group nodes by team convention.
- Rename a category as usage evolves.
- Audit how a site's palette is organised.
- Distinguish presentation from permission.
- Give custom node types a home in the palette.
- Keep the palette stable as node types are added.
