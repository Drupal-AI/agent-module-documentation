<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Blocks — agent index

Part of **ui_patterns**. Exposes each SDC component as a block plugin.

- Block plugin id: `ui_patterns:<component_id>`, e.g. `ui_patterns:olivero:teaser`
  (base id `ui_patterns`, deriver `DerivativeComponentBlock`).
- Config stored on `block.block.<id>` under `settings.ui_patterns`.
- How to place/configure one: [configure/block.md](configure/block.md)
- Full `ui_patterns` settings shape + Source ids: parent module's
  `agent/configure/components.md`.
