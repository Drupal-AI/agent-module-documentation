<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Demo (vlsuite_demo) — agent index

Submodule of **vlsuite**. Installs **example pages and configuration** so the suite can be seen
working. Version **2.3.3**. Core `^10.3 || ^11`.
Pulls in `vlsuite_landing_content_editor`, `_collection_hero`, `_collection_stmt`,
`_collection_card`, `_collection_gallery`, `_layout_tabs`, `_block_headings_menu`.

The right first step when evaluating the suite, and a **worked reference** for how components are
meant to combine.

**Remove before launch, and verify.** Demo content is content — it appears in listings, search,
sitemaps and content counts. Uninstalling the module does not necessarily remove content it
created; check what is left. Same class as `acquia_purge_varnish_test` for a production audit.