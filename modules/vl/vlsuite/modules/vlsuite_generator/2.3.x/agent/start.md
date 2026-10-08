<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Generator (vlsuite_generator) — agent index

Submodule of **vlsuite**. **Drush generator** for modules containing VLSuite components —
`drush generate vlsuite-module`, from a chosen library template.
Version **2.3.3**. Core `^10.3 || ^11`.
Depends on `vlsuite_block`, `vlsuite_layout`, `section_library`, **`default_content`**.

`default_content` lets generated components ship with example content; `section_library` lets
generated sections be saved and reused like built-in ones.

**Two points:** generated code is a starting point, not a finished component; and it encodes the
suite's conventions, so prefer regenerating over hand-patching when those change.