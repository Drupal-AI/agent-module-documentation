<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Block: Text (vlsuite_block_text) — agent index

Nested submodule of **vlsuite_block**. **Rich-text** component.
Version **2.3.3**. Core `^10.3 || ^11`.

The constraints live outside the component: the **text format** decides allowed markup,
**utility classes** decide spacing/alignment, the **section** decides width. Narrow-column and
full-bleed are the same component in different places.

**Debugging:** formatting dropped on save is the text format stripping markup, not the component.
See `vlsuite_format`.