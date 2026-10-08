<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Wingsuit Layout Builder (wingsuit_lb) — agent index

Submodule of **wingsuit_companion**. Makes Wingsuit components placeable in **Layout Builder**,
using **Layout Builder Browser** for the picker.
Version **8.x-2.2**. Core `^8 || ^9 || ^10 || ^11`. Depends on `layout_builder_browser (>=1.7)`.

Thin bridge: components come from the Wingsuit project, placement mechanics from Layout Builder.

**Why the picker matters:** Layout Builder's stock block list is a long alphabetical dropdown. Past
about thirty components that is where editors give up. Layout Builder Browser groups and
illustrates them — that is what turns a library into something used.