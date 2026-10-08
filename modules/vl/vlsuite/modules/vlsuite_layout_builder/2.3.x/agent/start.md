<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Layout Builder (vlsuite_layout_builder) — agent index

Submodule of **vlsuite**. The **Layout Builder editing experience**: contextual operations, modal
editing, section library. Version **2.3.3**. Core `^10.3 || ^11`.
Depends on `contextual`, `editor`, `layout_builder_operation_link`, `section_library`,
`vlsuite_modal`, `vlsuite_utility_classes`, `vlsuite_layout`, `vlsuite_block`.

Addresses core Layout Builder's three ergonomics problems: operations hidden behind small
contextual links, a sidebar that covers what you are editing, and no way to save a section for
reuse.

**The section library needs governance.** Uncurated, it accumulates near-duplicates within months
and editors stop using it. Decide who curates before it fills — same point as
`lb_plus_section_library`.

Distinct from **`vlsuite_layout`**, which supplies the layouts themselves.