<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entityform Block (entityform_block) — agent index

Blocks that render **add/edit forms for content entities**, placeable via block/Layout Builder UI.
Version **dev (1.x)**. Core `^9 || ^10 || ^11`.

**Access control is the key concern:** the block renders a real entity form that **saves an
entity**, so it must only be reachable by users allowed to create/edit that type. It adds no access
control beyond the entity form + block visibility — align the two (an add-form block in a public
region exposes entity creation).