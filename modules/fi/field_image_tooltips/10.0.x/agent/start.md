<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Image Tooltips — agent orientation

D8/9/10 module (dir version 10.0.x) rendering images with tooltips that open a referenced node in a modal. Ships submodule `field_tooltips_data` (field type/widget/formatter under `modules/field_tooltips_data/`).

- Depends on contrib `paragraphs` plus core field/file/image/node.
- Tooltip content route: `/tooltip/{node}/{js}` -> `TooltipsDataController::tooltip`, permission `access content`, renders the node via the node view builder in a modal.
