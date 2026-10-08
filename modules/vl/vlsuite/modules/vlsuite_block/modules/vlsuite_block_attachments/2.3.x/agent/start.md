<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Block: Attachments (vlsuite_block_attachments) — agent index

Nested submodule of **vlsuite_block**. **File attachments / downloads** component.
Version **2.3.3**. Core `^10.3 || ^11`.

**Two things to state:**

1. **File type and size belong in the link text** — a visitor should know it is a 12MB PDF before
   tapping on mobile data. Usability requirement, and explicit in several public-sector
   accessibility standards. Check whether the component renders it.
2. **`private://` vs `public://` matters.** Private files are served through Drupal with access
   checks — correct, but not edge-cacheable, which matters for a popular document. Public files
   are directly served and directly guessable: fine for a brochure, wrong for anything
   restricted.