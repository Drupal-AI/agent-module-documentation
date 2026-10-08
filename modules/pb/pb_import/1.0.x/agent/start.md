<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PB Import — agent index

Imports content and **creates nodes/paragraphs from a source file** (bulk/page-builder content creation).
Depends on `paragraphs`, `entity_reference_revisions` + core content modules. Submodules `pb_import_node`,
`pb_import_para`. Version **1.0.1**. Core `^10||^11`.

Import/content — **processes an external source file** (validate input, apply **safe text formats** to
imported markup; run as a trusted operator). No access role.
