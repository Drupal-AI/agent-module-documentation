<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Layouts — agent index

Part of **ui_patterns**. Exposes each SDC component as a layout plugin (needs core
`layout_discovery`).

- Layout plugin id: `ui_patterns:<component_id>`, e.g. `ui_patterns:olivero:teaser`
  (base id `ui_patterns`, deriver `DerivativeComponentLayout`).
- The component's **slots** become the layout's **regions**; **props** are set in the
  layout settings form.
- How to use one: [configure/layout.md](configure/layout.md)
- Full `ui_patterns` settings shape + Source ids: parent module's
  `agent/configure/components.md`.
