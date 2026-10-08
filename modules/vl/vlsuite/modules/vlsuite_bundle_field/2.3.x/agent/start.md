<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Bundle Field (vlsuite_bundle_field) — agent index

Submodule of **vlsuite**. **Shared field definitions** across the suite's block and collection
bundles. Version **2.3.3**. Core `^10.3 || ^11`.
Depends on `content_translation`, `link`, `media`, `entity`, `vlsuite`, `vlsuite_icon_font`.
`vlsuite_collection` depends on it.

The same field name meaning the same thing everywhere is what keeps a component library coherent —
displays configured once, changes propagating, cross-component queries possible.

`content_translation` is a dependency because shared definitions are what make a **translatable**
component set tractable rather than a per-bundle exercise.

**When extending the suite, reuse these fields** rather than adding parallel ones.