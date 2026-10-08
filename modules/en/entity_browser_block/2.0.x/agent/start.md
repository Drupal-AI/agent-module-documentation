<!--
SPDX-License-Identifier: GPL-2.0-or-later
-->
# entity_browser_block — agent index

Provides one derivable block plugin, `entity_browser_block`, whose deriver
(`EntityBrowserBlockDeriver`) creates a block derivative for **every Entity Browser** on the
site. Plugin id: `entity_browser_block:{browser_machine_name}`. Placing the block embeds that
browser to select entities, then you set a view mode per entity. No settings form, no
`configure` route, no permissions, no services, no submodules. An Entity Browser must exist
first (the deriver keys off `entity_browser` config entities).

- **The derived block plugin + deriver, settings shape (`entity_ids`, `view_modes`)** → [plugins/entity_browser_block.md](plugins/entity_browser_block.md)
- **Place / configure a block, in the UI or as `block` config** → [configure/entity_browser_block.md](configure/entity_browser_block.md)
